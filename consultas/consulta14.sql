﻿/* 14- Encontre	todos os Postos localizadas fora da cidade de Cabedelo */
SELECT posto AS postos
FROM
(SELECT posto.estacao AS posto, ST_Contains((ST_Transform(cidade_a.geom,29195)),(ST_Transform(posto.geom,29195))) AS contains
FROM sig.municipios cidade_a, sig.postos posto WHERE cidade_a.nome_munic = 'Cabedelo') AS consulta_postos WHERE consulta_postos.contains = false