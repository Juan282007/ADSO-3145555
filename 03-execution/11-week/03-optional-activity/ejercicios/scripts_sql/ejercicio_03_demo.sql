DO $$
DECLARE
    v_invoice_id       uuid;
    v_tax_id           uuid;
    v_line_number      integer;
    v_line_description varchar := 'Servicio de transporte aéreo - segmento adicional';
    v_quantity         numeric := 1;
    v_unit_price       numeric := 150.00;
BEGIN
    -- Buscar una factura existente en el sistema
    SELECT i.invoice_id
    INTO v_invoice_id
    FROM invoice i
    ORDER BY i.created_at
    LIMIT 1;

    -- Obtener el primer impuesto disponible
    SELECT t.tax_id
    INTO v_tax_id
    FROM tax t
    ORDER BY t.created_at
    LIMIT 1;

    -- Determinar el siguiente número de línea disponible para esa factura
    SELECT COALESCE(MAX(il.line_number), 0) + 1
    INTO v_line_number
    FROM invoice_line il
    WHERE il.invoice_id = v_invoice_id;

    IF v_invoice_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna factura disponible en el sistema.';
    END IF;

    IF v_tax_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún impuesto disponible en el sistema.';
    END IF;

    -- Invocar el procedimiento de registro de línea facturable
    CALL sp_register_invoice_line(
        v_invoice_id,
        v_tax_id,
        v_line_number,
        v_line_description,
        v_quantity,
        v_unit_price
    );
END;
$$;

-- Validación: verificar la línea registrada y el notes actualizado en la factura por el trigger
SELECT
    i.invoice_id,
    i.invoice_number,
    i.notes                    AS trazabilidad_factura,
    il.line_number,
    il.line_description,
    il.quantity,
    il.unit_price,
    t.tax_name
FROM invoice i
INNER JOIN invoice_line il
    ON il.invoice_id = i.invoice_id
INNER JOIN tax t
    ON t.tax_id = il.tax_id
ORDER BY il.created_at DESC
LIMIT 5;