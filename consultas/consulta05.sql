/*5- Encontrar todos os	municípios que estejam a menos de 50km de Campina Grande.*/
SELECT cidade 
FROM
(SELECT cidade_b.nome_munic AS cidade, ST_Contains((ST_Buffer(ST_Transform(cidade_a.geom,29195), 50000)),(ST_Transform(ST_Centroid(cidade_b.geom),29195))) AS contains
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 52) AS consulta_buffer WHERE consulta_buffer.contains = true