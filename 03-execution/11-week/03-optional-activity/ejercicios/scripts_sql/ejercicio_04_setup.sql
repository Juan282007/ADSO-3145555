DROP TRIGGER IF EXISTS trg_ai_miles_transaction_update_account_tier ON miles_transaction;
DROP FUNCTION IF EXISTS fn_ai_miles_transaction_update_account_tier() CASCADE;
DROP PROCEDURE IF EXISTS sp_register_miles_transaction(uuid, varchar, integer, timestamptz, text);

CREATE OR REPLACE FUNCTION fn_ai_miles_transaction_update_account_tier()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_miles       bigint;
    v_new_tier_id       uuid;
    v_current_tier_id   uuid;
BEGIN
    -- Calcular el total acumulado de miles_delta de la cuenta
    SELECT COALESCE(SUM(mt.miles_delta), 0)
    INTO v_total_miles
    FROM miles_transaction mt
    WHERE mt.loyalty_account_id = NEW.loyalty_account_id;

    -- Buscar el tier cuyo required_miles más alto no supere el total acumulado
    SELECT lt.loyalty_tier_id
    INTO v_new_tier_id
    FROM loyalty_tier lt
    INNER JOIN loyalty_account la
        ON la.loyalty_program_id = lt.loyalty_program_id
    WHERE la.loyalty_account_id = NEW.loyalty_account_id
      AND lt.required_miles <= v_total_miles
    ORDER BY lt.required_miles DESC
    LIMIT 1;

    IF v_new_tier_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Verificar el tier activo actual (el que no tiene expires_at o el más reciente)
    SELECT lat.loyalty_tier_id
    INTO v_current_tier_id
    FROM loyalty_account_tier lat
    WHERE lat.loyalty_account_id = NEW.loyalty_account_id
      AND (lat.expires_at IS NULL OR lat.expires_at > now())
    ORDER BY lat.assigned_at DESC
    LIMIT 1;

    -- Solo actuar si el tier calculado es diferente al actual
    IF v_current_tier_id IS DISTINCT FROM v_new_tier_id THEN
        -- Cerrar el tier activo anterior
        UPDATE loyalty_account_tier
        SET expires_at = now()
        WHERE loyalty_account_id = NEW.loyalty_account_id
          AND (expires_at IS NULL OR expires_at > now());

        -- Insertar el nuevo tier
        INSERT INTO loyalty_account_tier (
            loyalty_account_id,
            loyalty_tier_id,
            assigned_at,
            expires_at
        )
        VALUES (
            NEW.loyalty_account_id,
            v_new_tier_id,
            now(),
            NULL
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_miles_transaction_update_account_tier
AFTER INSERT ON miles_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_miles_transaction_update_account_tier();

CREATE OR REPLACE PROCEDURE sp_register_miles_transaction(
    p_loyalty_account_id   uuid,
    p_transaction_type     varchar,
    p_miles_delta          integer,
    p_occurred_at          timestamptz,
    p_notes                text
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM loyalty_account la
        WHERE la.loyalty_account_id = p_loyalty_account_id
    ) THEN
        RAISE EXCEPTION 'No existe una cuenta de fidelización con loyalty_account_id %', p_loyalty_account_id;
    END IF;

    IF p_transaction_type NOT IN ('EARN', 'REDEEM', 'ADJUST') THEN
        RAISE EXCEPTION 'Tipo de transacción inválido: %. Valores permitidos: EARN, REDEEM, ADJUST', p_transaction_type;
    END IF;

    IF p_miles_delta = 0 THEN
        RAISE EXCEPTION 'El valor de miles_delta no puede ser cero.';
    END IF;

    INSERT INTO miles_transaction (
        loyalty_account_id,
        transaction_type,
        miles_delta,
        occurred_at,
        notes
    )
    VALUES (
        p_loyalty_account_id,
        p_transaction_type,
        p_miles_delta,
        p_occurred_at,
        p_notes
    );
END;
$$;

-- Consulta resuelta: trazabilidad fidelización cliente-persona-cuenta-programa-nivel-venta
SELECT
    c.customer_id,
    p.first_name,
    p.last_name,
    la.account_number          AS cuenta_fidelizacion,
    lp.program_name            AS programa,
    lt.tier_name               AS nivel,
    lat.assigned_at            AS fecha_asignacion_nivel,
    s.sale_code                AS venta_relacionada
FROM customer c
INNER JOIN person p
    ON p.person_id = c.person_id
INNER JOIN loyalty_account la
    ON la.customer_id = c.customer_id
INNER JOIN loyalty_program lp
    ON lp.loyalty_program_id = la.loyalty_program_id
INNER JOIN loyalty_account_tier lat
    ON lat.loyalty_account_id = la.loyalty_account_id
INNER JOIN loyalty_tier lt
    ON lt.loyalty_tier_id = lat.loyalty_tier_id
INNER JOIN reservation r
    ON r.booked_by_customer_id = c.customer_id
INNER JOIN sale s
    ON s.reservation_id = r.reservation_id
ORDER BY lat.assigned_at DESC, c.customer_id;