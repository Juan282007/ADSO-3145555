DROP TRIGGER IF EXISTS trg_ai_person_document_audit_contact ON person_document;
DROP FUNCTION IF EXISTS fn_ai_person_document_audit_contact();
DROP PROCEDURE IF EXISTS sp_register_person_document(uuid, uuid, varchar, date, date, uuid);


CREATE OR REPLACE FUNCTION fn_ai_person_document_audit_contact()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_contact_type_id uuid;
    v_contact_value   varchar(200);
BEGIN
    v_contact_value := 'DOC-AUDIT:' || NEW.document_number;

    -- Verificar si ya existe un contacto de auditoría para este documento
    IF EXISTS (
        SELECT 1
        FROM person_contact pc
        WHERE pc.person_id = NEW.person_id
          AND pc.contact_value = v_contact_value
    ) THEN
        RETURN NEW;
    END IF;

    -- Obtener el primer tipo de contacto disponible
    SELECT ct.contact_type_id
    INTO v_contact_type_id
    FROM contact_type ct
    ORDER BY ct.created_at
    LIMIT 1;

    IF v_contact_type_id IS NULL THEN
        RETURN NEW;
    END IF;

    INSERT INTO person_contact (
        person_id,
        contact_type_id,
        contact_value
    )
    VALUES (
        NEW.person_id,
        v_contact_type_id,
        v_contact_value
    );

    RETURN NEW;
END;
$$;


CREATE TRIGGER trg_ai_person_document_audit_contact
AFTER INSERT ON person_document
FOR EACH ROW
EXECUTE FUNCTION fn_ai_person_document_audit_contact();


CREATE OR REPLACE PROCEDURE sp_register_person_document(
    p_person_id          uuid,
    p_document_type_id   uuid,
    p_document_number    varchar,
    p_issued_on          date,        -- CORRECCIÓN: nombre alineado con columna real del esquema
    p_expires_on         date,        -- CORRECCIÓN: nombre alineado con columna real del esquema
    p_issuing_country_id uuid
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validar que no exista el mismo documento para la misma persona
    IF EXISTS (
        SELECT 1
        FROM person_document pd
        WHERE pd.person_id = p_person_id
          AND pd.document_type_id = p_document_type_id
          AND pd.document_number = p_document_number
    ) THEN
        RAISE EXCEPTION 'Ya existe un documento del mismo tipo y número para la persona %', p_person_id;
    END IF;

    INSERT INTO person_document (
        person_id,
        document_type_id,
        document_number,
        issued_on,           -- CORRECCIÓN: nombre real de columna (antes issue_date)
        expires_on,          -- CORRECCIÓN: nombre real de columna (antes expiration_date)
        issuing_country_id
    )
    VALUES (
        p_person_id,
        p_document_type_id,
        p_document_number,
        p_issued_on,
        p_expires_on,
        p_issuing_country_id
    );
END;
$$;

SELECT
    p.first_name                        AS nombre,
    p.last_name                         AS apellido,
    pt.type_name                        AS tipo_persona,        -- CORRECCIÓN: columna real (antes person_type_name)
    dt.type_name                        AS tipo_documento,      -- CORRECCIÓN: columna real (antes document_type_name)
    pd.document_number                  AS numero_documento,
    pd.expires_on                       AS vencimiento_documento, -- CORRECCIÓN: columna real (antes expiration_date)
    ct.type_name                        AS tipo_contacto,       -- CORRECCIÓN: columna real (antes contact_type_name)
    pc.contact_value                    AS valor_contacto,
    r.reservation_code                  AS reserva,
    rp.passenger_sequence_no            AS secuencia_pasajero   -- CORRECCIÓN: columna real (antes sequence_number)
FROM person p
INNER JOIN person_type pt
    ON pt.person_type_id = p.person_type_id
INNER JOIN person_document pd
    ON pd.person_id = p.person_id
INNER JOIN document_type dt
    ON dt.document_type_id = pd.document_type_id
INNER JOIN person_contact pc
    ON pc.person_id = p.person_id
INNER JOIN contact_type ct
    ON ct.contact_type_id = pc.contact_type_id
INNER JOIN reservation_passenger rp
    ON rp.person_id = p.person_id
INNER JOIN reservation r
    ON r.reservation_id = rp.reservation_id
ORDER BY p.last_name, p.first_name, pd.document_number;