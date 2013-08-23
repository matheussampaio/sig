/*9- Mostre os municípios que são cortados pela	Rodovia	PB-030?*/

SELECT cidade
FROM
(SELECT cidade_a.nome_munic AS cidade, ST_Crosses((ST_Transform(cidade_a.geom,29195)),(ST_Transform(rodovia.geom,29195))) AS crosses
FROM sig.municipios cidade_a, sig.rodovias rodovia WHERE rodovia.codrodov = 'PB-030') AS consulta_atravessa WHERE consulta_atravessa.crosses = true