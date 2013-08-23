/*8- Quais são as rodovias que atravessam o município de João Pessoa?*/

SELECT rodovia
FROM
(SELECT rodovia.codrodov AS rodovia, ST_Crosses((ST_Transform(cidade_a.geom,29195)),(ST_Transform(rodovia.geom,29195))) AS crosses
FROM sig.municipios cidade_a, sig.rodovias rodovia WHERE cidade_a.gid = 96) AS consulta_atravessa WHERE consulta_atravessa.crosses = true GROUP BY rodovia