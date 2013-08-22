/* 3- Qual a distância de Patos para Campina Grande? (Distancia convertida em KM) */
SELECT ST_Distance(ST_Transform(a.geom,29195), ST_Transform(b.geom,29195)) / 1000
FROM sig.municipios a, sig.municipios b WHERE a.gid = 52 AND b.gid = 136
