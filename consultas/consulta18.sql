/* 18- Quais municípios	interceptam o açude Epitácio Pessoa? */

SELECT cidade
FROM
(SELECT cidade_a.nome_munic AS cidade, ST_Crosses((ST_Transform(acude.geom,29195)),(ST_Transform(cidade_a.geom,29195))) AS crosses
FROM sig.municipios cidade_a, sig.acudagem_principal acude WHERE acude.nome = 'Aç. Epitácio Pessoa') AS consulta_atravessa WHERE consulta_atravessa.crosses = true