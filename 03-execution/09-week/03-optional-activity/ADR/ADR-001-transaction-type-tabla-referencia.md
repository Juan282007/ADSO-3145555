# ADR-001: Tabla de referencia para tipos de transacción de millas

- **Estado:** Accepted
- **Fecha:** 2026-04-11

## Contexto

`miles_transaction.transaction_type` usaba un `CHECK` constraint con los valores `EARN`, `REDEEM` y `ADJUST` hardcodeados. El resto del esquema usa tablas de referencia con FK para todos los dominios enumerables. Agregar un nuevo tipo de transacción requería `ALTER TABLE` en producción.

## Decisión

Se crea la tabla `transaction_type` y se reemplaza el campo `varchar + CHECK` por una FK.

## Consecuencias

- Nuevos tipos de transacción se agregan como filas, sin tocar el esquema.
- Requiere una migración de datos para poblar la FK antes de aplicar el `NOT NULL`.
- Queries que filtraban `WHERE transaction_type = 'EARN'` deben pasar a usar JOIN.
