/* 10- Quais os	postos que estão num raio de 15km da BR-230? */

SELECT posto 
FROM
(SELECT posto.estacao AS posto, ST_Contains((ST_Buffer(ST_Transform(rodovia.geom,29195), 15000)),(ST_Transform(posto.geom,29195))) AS contains
FROM sig.rodovias rodovia, sig.postos posto WHERE rodovia.codrodov = 'BR-230') AS consulta_buffer WHERE consulta_buffer.contains = true GROUP BY posto
