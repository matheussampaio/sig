/*6- Quantos postos pluviométricos estão localizados no município de Campina Grande? */
SELECT COUNT(posto) AS postos
FROM
(SELECT posto.estacao AS posto, ST_Contains((ST_Transform(cidade_a.geom,29195)),(ST_Transform(posto.geom,29195))) AS contains
FROM sig.municipios cidade_a, sig.postos posto WHERE cidade_a.gid = 52) AS consulta_postos WHERE consulta_postos.contains = true