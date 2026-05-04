DO $$
DECLARE
    v_payment_id             uuid;
    v_transaction_reference  varchar;
    v_transaction_type       varchar := 'REVERSAL';
    v_transaction_amount     numeric;
    v_processed_at           timestamptz := now();
    v_provider_message       text := 'Reversión procesada por proveedor externo';
BEGIN
    -- Buscar un pago que no tenga aún una transacción de tipo REVERSAL o REFUND
    SELECT p.payment_id, p.amount
    INTO v_payment_id, v_transaction_amount
    FROM payment p
    WHERE NOT EXISTS (
        SELECT 1
        FROM payment_transaction pt
        WHERE pt.payment_id = p.payment_id
          AND pt.transaction_type IN ('REFUND', 'REVERSAL')
    )
    ORDER BY p.created_at
    LIMIT 1;

    -- Si no hay ninguno sin reversión, tomar cualquier pago disponible
    IF v_payment_id IS NULL THEN
        SELECT p.payment_id, p.amount
        INTO v_payment_id, v_transaction_amount
        FROM payment p
        ORDER BY p.created_at
        LIMIT 1;
    END IF;

    IF v_payment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún pago disponible en el sistema.';
    END IF;

    -- Generar referencia única de transacción
    v_transaction_reference := 'TXN-' || left(replace(v_payment_id::text, '-', ''), 28);

    -- Invocar el procedimiento de registro de transacción
    CALL sp_register_payment_transaction(
        v_payment_id,
        v_transaction_reference,
        v_transaction_type,
        v_transaction_amount,
        v_processed_at,
        v_provider_message
    );
END;
$$;

-- Validación: verificar la transacción registrada y el refund generado por el trigger
SELECT
    pt.payment_transaction_id,
    pt.payment_id,
    pt.transaction_reference,
    pt.transaction_type,
    pt.transaction_amount,
    pt.processed_at,
    r.refund_id,
    r.refund_reference,
    r.amount               AS monto_devuelto,
    r.refund_reason,
    r.requested_at
FROM payment_transaction pt
LEFT JOIN refund r
    ON r.payment_id = pt.payment_id
ORDER BY pt.processed_at DESC
LIMIT 5;