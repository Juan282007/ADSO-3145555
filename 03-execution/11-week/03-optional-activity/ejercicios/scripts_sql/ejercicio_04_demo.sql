DO $$
DECLARE
    v_loyalty_account_id   uuid;
    v_transaction_type     varchar := 'EARN';
    v_miles_delta          integer := 5000;
    v_occurred_at          timestamptz := now();
    v_notes                text := 'Acumulación por vuelo operado - registro automático';
BEGIN
    -- Buscar una cuenta de fidelización activa disponible
    SELECT la.loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account la
    ORDER BY la.created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna cuenta de fidelización disponible en el sistema.';
    END IF;

    -- Invocar el procedimiento de registro de transacción de millas
    CALL sp_register_miles_transaction(
        v_loyalty_account_id,
        v_transaction_type,
        v_miles_delta,
        v_occurred_at,
        v_notes
    );
END;
$$;

-- Validación: verificar la transacción registrada y el tier actualizado por el trigger
SELECT
    mt.miles_transaction_id,
    mt.loyalty_account_id,
    mt.transaction_type,
    mt.miles_delta,
    mt.occurred_at,
    mt.notes,
    lat.loyalty_tier_id,
    lt.tier_name               AS nivel_asignado,
    lat.assigned_at            AS inicio_nivel,
    lat.expires_at             AS fin_nivel
FROM miles_transaction mt
INNER JOIN loyalty_account_tier lat
    ON lat.loyalty_account_id = mt.loyalty_account_id
    AND (lat.expires_at IS NULL OR lat.expires_at > now())
INNER JOIN loyalty_tier lt
    ON lt.loyalty_tier_id = lat.loyalty_tier_id
WHERE mt.loyalty_account_id = (
    SELECT loyalty_account_id
    FROM miles_transaction
    ORDER BY created_at DESC
    LIMIT 1
)
ORDER BY mt.occurred_at DESC
LIMIT 5;