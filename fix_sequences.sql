-- Исправление последовательностей для типов вездеходов и местности
SELECT setval('terrain_types_id_seq', (SELECT max(id) FROM terrain_types));
SELECT setval('vehicle_types_id_seq', (SELECT max(id) FROM vehicle_types));
