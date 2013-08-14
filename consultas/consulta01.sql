SELECT a.nome AS Nome, ST_Area(a.geom) AS Comprimento
FROM sig.acudagem_principal a
ORDER BY Comprimento DESC