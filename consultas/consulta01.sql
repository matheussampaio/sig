/* 1- Qual o maior açude da PB? */
SELECT acudes.nome AS nome, ST_Area(acudes.geom) AS area
FROM sig.acudagem_principal acudes
ORDER BY area DESC LIMIT 1