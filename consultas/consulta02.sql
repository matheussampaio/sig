/* 2- Qual o comprimento da rodovia 'PB-008'? (Distancia convertida em KM)*/
SELECT rodovias.codrodov AS nome, sum(st_length(ST_Transform(rodovias.geom, 29195))) / 1000 AS comprimento
FROM sig.rodovias rodovias
WHERE rodovias.codrodov = 'PB-008' GROUP BY rodovias.codrodov