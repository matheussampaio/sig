/*11- Qual ferrovia corta o maior número de municípios?*/
SELECT consulta_ferrovias.ferrovia, COUNT(consulta_ferrovias.cidade) AS cidades
FROM
(SELECT  ferrovia.gid AS ferrovia, cidade_a.nome_munic AS cidade, ST_Crosses((ST_Transform(cidade_a.geom,29195)),(ST_Transform(ferrovia.geom,29195))) AS crosses
FROM sig.municipios cidade_a, sig.estrada_ferro ferrovia) AS consulta_ferrovias WHERE consulta_ferrovias.crosses = true GROUP BY ferrovia ORDER BY cidades DESC LIMIT 1