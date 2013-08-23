/*7- Mostre todos os municípios	que são	vizinhos de Ingá. */
SELECT cidade 
FROM
(SELECT cidade_b.nome_munic AS cidade, ST_Touches((ST_Transform(cidade_a.geom,29195)),(ST_Transform(cidade_b.geom,29195))) AS touches
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 89) AS consulta_vizinhos WHERE consulta_vizinhos.touches = true