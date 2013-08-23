/*16- Mostre os	açudes que estão no município de Campina Grande. */

SELECT acude 
FROM
(SELECT acude.nome AS acude, ST_Contains((ST_Transform(cidade_a.geom,29195)),(ST_Transform(acude.geom,29195))) AS contains
FROM sig.municipios cidade_a, sig.acudagem_principal acude WHERE cidade_a.nome_munic = 'Campina Grande') AS consulta_contains WHERE consulta_contains.contains = true