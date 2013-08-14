SELECT acudes.nome AS nome, ST_Area(acudes.geom) AS comprimento
FROM sig.acudagem_principal acudes
ORDER BY comprimento DESC LIMIT 1