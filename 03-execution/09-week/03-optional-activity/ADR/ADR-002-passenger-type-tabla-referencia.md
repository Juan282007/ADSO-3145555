# ADR-002: Tabla de referencia para tipo de pasajero

- **Estado:** Accepted
- **Fecha:** 2026-04-11

## Contexto

`reservation_passenger.passenger_type` usaba un `CHECK` constraint con los valores `ADULT`, `CHILD` e `INFANT` hardcodeados. Los tipos de pasajero tienen reglas propias (edad mínima/máxima, si requieren acompañante) que no podían expresarse en ese modelo.

## Decisión

Se crea la tabla `passenger_type` con campos `min_age_years`, `max_age_years` y `requires_companion`, y se reemplaza el campo `varchar + CHECK` por una FK.

## Consecuencias

- Las reglas por tipo de pasajero se pueden actualizar sin tocar el esquema principal.
- Requiere migración de datos igual que ADR-001.
- ADR-001 y ADR-002 deben ejecutarse en la misma ventana de mantenimiento para mantener consistencia.
