# ADR-003: Tablas de referencia para tipo y estado de equipaje

- **Estado:** Accepted
- **Fecha:** 2026-04-11

## Contexto

`baggage` tenía dos `CHECK` constraints hardcodeados: `baggage_type` con valores `CHECKED`, `CARRY_ON`, `SPECIAL` y `baggage_status` con valores `REGISTERED`, `LOADED`, `CLAIMED`, `LOST`. Los estados del equipaje siguen una máquina de estados que puede crecer (ej. `DELAYED`, `DAMAGED`, `IN_CUSTOMS`).

## Decisión

Se crean las tablas `baggage_type` y `baggage_status`. La tabla `baggage_status` incluye el campo `is_terminal_state boolean` para modelar explícitamente qué estados son finales.

## Consecuencias

- Nuevos tipos y estados se agregan como filas sin DDL.
- El campo `is_terminal_state` permite que la lógica de negocio identifique estados finales sin hardcodear nombres en el código de aplicación.
- Requiere dos migraciones de datos en la misma tabla `baggage`.
