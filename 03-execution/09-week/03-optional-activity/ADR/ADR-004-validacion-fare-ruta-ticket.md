# ADR-004: Trigger de validación entre tarifa y ruta del ticket

- **Estado:** Accepted
- **Fecha:** 2026-04-11

## Contexto

`ticket` referencia una `fare_id` que tiene `origin_airport_id` y `destination_airport_id`. Los `flight_segment` asociados al ticket (vía `ticket_segment`) también tienen origen y destino. No había ninguna restricción que garantizara que ambos coincidieran: era posible guardar un ticket con tarifa BOG→MIA pero con segmentos de vuelo que iban por otra ruta.

## Decisión

Se agrega un `CONSTRAINT TRIGGER DEFERRABLE INITIALLY DEFERRED` en `ticket_segment` que verifica que el origen del primer segmento y el destino del último coincidan con los aeropuertos declarados en la tarifa del ticket.

Se eligió un trigger en lugar de validación en capa de aplicación porque es imposible de omitir en inserciones directas o migraciones. Se marca como `DEFERRED` para permitir insertar todos los segmentos dentro de la misma transacción antes de validar.

## Consecuencias

- El SGBD garantiza la coherencia entre precios y operaciones sin depender de la aplicación.
- Agrega una pequeña latencia en escrituras sobre `ticket_segment`.
- Requiere manejo cuidadoso en itinerarios de ida y vuelta: el fare debe representar el tramo completo.
