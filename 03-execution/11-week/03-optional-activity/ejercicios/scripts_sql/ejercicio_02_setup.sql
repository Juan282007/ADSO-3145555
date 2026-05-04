DROP TRIGGER IF EXISTS trg_ai_payment_transaction_create_refund ON payment_transaction;
DROP FUNCTION IF EXISTS fn_ai_payment_transaction_create_refund();
DROP PROCEDURE IF EXISTS sp_register_payment_transaction(uuid, varchar, varchar, numeric, timestamptz, text);

CREATE OR REPLACE FUNCTION fn_ai_payment_transaction_create_refund()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_refund_reference   varchar(40);
BEGIN
    -- Solo actuar cuando la transacción es de tipo REFUND o REVERSAL
    IF NEW.transaction_type NOT IN ('REFUND', 'REVERSAL') THEN
        RETURN NEW;
    END IF;

    -- Evitar duplicar un refund para el mismo payment
    IF EXISTS (
        SELECT 1
        FROM refund r
        WHERE r.payment_id = NEW.payment_id
    ) THEN
        RETURN NEW;
    END IF;

    -- Generar referencia única de devolución
    v_refund_reference := 'REF-' || left(replace(NEW.payment_transaction_id::text, '-', ''), 32);

    INSERT INTO refund (
        payment_id,
        refund_reference,
        amount,
        requested_at,
        processed_at,
        refund_reason
    )
    VALUES (
        NEW.payment_id,
        left(v_refund_reference, 40),
        NEW.transaction_amount,
        NEW.processed_at,
        NEW.processed_at,
        'Devolución automática generada por transacción ' || NEW.transaction_type
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_payment_transaction_create_refund
AFTER INSERT ON payment_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_payment_transaction_create_refund();

CREATE OR REPLACE PROCEDURE sp_register_payment_transaction(
    p_payment_id             uuid,
    p_transaction_reference  varchar,
    p_transaction_type       varchar,
    p_transaction_amount     numeric,
    p_processed_at           timestamptz,
    p_provider_message       text
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM payment p
        WHERE p.payment_id = p_payment_id
    ) THEN
        RAISE EXCEPTION 'No existe un pago con payment_id %', p_payment_id;
    END IF;

    IF p_transaction_type NOT IN ('AUTH', 'CAPTURE', 'VOID', 'REFUND', 'REVERSAL') THEN
        RAISE EXCEPTION 'Tipo de transacción inválido: %. Valores permitidos: AUTH, CAPTURE, VOID, REFUND, REVERSAL', p_transaction_type;
    END IF;

    INSERT INTO payment_transaction (
        payment_id,
        transaction_reference,
        transaction_type,
        transaction_amount,
        processed_at,
        provider_message
    )
    VALUES (
        p_payment_id,
        p_transaction_reference,
        p_transaction_type,
        p_transaction_amount,
        p_processed_at,
        p_provider_message
    );
END;
$$;

-- Consulta resuelta: trazabilidad financiera venta-pago-transacción-moneda
SELECT
    s.sale_code,
    r.reservation_code,
    p.payment_reference,
    ps.status_name             AS estado_pago,
    pm.method_name             AS metodo_pago,
    pt.transaction_reference,
    pt.transaction_type,
    pt.transaction_amount      AS monto_procesado,
    c.iso_currency_code        AS moneda
FROM sale s
INNER JOIN reservation r
    ON r.reservation_id = s.reservation_id
INNER JOIN payment p
    ON p.sale_id = s.sale_id
INNER JOIN payment_status ps
    ON ps.payment_status_id = p.payment_status_id
INNER JOIN payment_method pm
    ON pm.payment_method_id = p.payment_method_id
INNER JOIN payment_transaction pt
    ON pt.payment_id = p.payment_id
INNER JOIN currency c
    ON c.currency_id = p.currency_id
ORDER BY pt.processed_at DESC;