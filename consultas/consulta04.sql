/*4) Qual a distância entre os centróides de Campina Grande e Patos? (Resposta convertida em KM)*/
SELECT ST_Distance(ST_Transform(ST_Centroid(a.geom),29195), ST_Transform(ST_Centroid(b.geom),29195)) / 1000
FROM sig.municipios a, sig.municipios b WHERE a.gid = 52 AND b.gid = 136