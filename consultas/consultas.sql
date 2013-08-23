/* Grupo 03: Bruno Miranda. Dirceu Medeiro e Matheus Sampaio*/

/* 01- Qual o maior açude da PB? */
SELECT acudes.nome AS nome, ST_Area(acudes.geom) AS area
FROM sig.acudagem_principal acudes
ORDER BY area DESC LIMIT 1;

/* 02- Qual o comprimento da rodovia 'PB-008'?
(Distancia convertida em KM)*/
SELECT rodovias.codrodov AS nome, sum(st_length(ST_Transform(rodovias.geom, 29195))) / 1000 AS comprimento
FROM sig.rodovias rodovias
WHERE rodovias.codrodov = 'PB-008' GROUP BY rodovias.codrodov;

/* 03- Qual a distância de Patos para Campina Grande?
(Distancia convertida em KM) (Distancia entre os poligonos)*/
SELECT ST_Distance(ST_Transform(cidade_a.geom,29195), ST_Transform(cidade_b.geom,29195)) / 1000 AS distancia
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 52 AND cidade_b.gid = 136;

/* 04- Qual a distância entre os centróides de Campina Grande e Patos? 
(Distancia convertida em KM)*/
SELECT ST_Distance(ST_Transform(ST_Centroid(cidade_a.geom),29195), ST_Transform(ST_Centroid(cidade_b.geom),29195)) / 1000 AS distancia
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 52 AND cidade_b.gid = 136;

/* 05- Encontrar todos os	municípios que estejam a menos de 50km de Campina Grande.
Consideramos os Centroids das cidades para decidir se estão no buffer ou não */
SELECT cidade 
FROM
(SELECT cidade_b.nome_munic AS cidade, ST_Contains((ST_Buffer(ST_Transform(cidade_a.geom,29195), 50000)),(ST_Transform(ST_Centroid(cidade_b.geom),29195))) AS contains
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 52) AS consulta_buffer WHERE consulta_buffer.contains = true;

/* 06- Quantos postos pluviométricos estão localizados no município de Campina Grande? */
SELECT COUNT(posto) AS postos
FROM
(SELECT posto.estacao AS posto, ST_Contains(cidade_a.geom, posto.geom) AS contains
FROM sig.municipios cidade_a, sig.postos posto WHERE cidade_a.gid = 52) AS consulta_postos WHERE consulta_postos.contains = true;

/* 07- Mostre todos os municípios	que são	vizinhos de Ingá. */
SELECT cidade 
FROM
(SELECT cidade_b.nome_munic AS cidade, ST_Touches(cidade_a.geom, cidade_b.geom) AS touches
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.gid = 89) AS consulta_vizinhos WHERE consulta_vizinhos.touches = true;

/* 08- Quais são as rodovias que atravessam o município de João Pessoa?
Como são varios trechos de uma rodovia agrupamos as mesmas e tem um valor em branco pois no shapefile tem algumas rodovidas não identificadas mas que cortam João Pessoa*/
SELECT rodovia
FROM
(SELECT rodovia.codrodov AS rodovia, ST_Crosses(cidade_a.geom,rodovia.geom) AS crosses
FROM sig.municipios cidade_a, sig.rodovias rodovia WHERE cidade_a.gid = 96) AS consulta_atravessa WHERE consulta_atravessa.crosses = true GROUP BY rodovia;

/* 09- Mostre os municípios que são cortados pela	Rodovia	PB-030?*/
SELECT cidade
FROM
(SELECT cidade_a.nome_munic AS cidade, ST_Crosses(cidade_a.geom,rodovia.geom) AS crosses
FROM sig.municipios cidade_a, sig.rodovias rodovia WHERE rodovia.codrodov = 'PB-030') AS consulta_atravessa WHERE consulta_atravessa.crosses = true;

/* 10- Quais os	postos que estão num raio de 15km da BR-230?*/
SELECT posto 
FROM
(SELECT posto.estacao AS posto, ST_Contains((ST_Buffer(ST_Transform(rodovia.geom,29195), 15000)),(ST_Transform(posto.geom,29195))) AS contains
FROM sig.rodovias rodovia, sig.postos posto WHERE rodovia.codrodov = 'BR-230') AS consulta_buffer WHERE consulta_buffer.contains = true GROUP BY posto;

/* 11- Qual ferrovia corta o maior número de municípios?
É mostrado o ID da ferrovia e o número de municipios pois no shape as ferrovias tinham apenas ID's*/
SELECT consulta_ferrovias.ferrovia, COUNT(consulta_ferrovias.cidade) AS cidades
FROM
(SELECT  ferrovia.gid AS ferrovia, cidade_a.nome_munic AS cidade, ST_Crosses(cidade_a.geom,ferrovia.geom) AS crosses
FROM sig.municipios cidade_a, sig.estrada_ferro ferrovia) AS consulta_ferrovias WHERE consulta_ferrovias.crosses = true GROUP BY ferrovia ORDER BY cidades DESC LIMIT 1;

/* 12- Monte o polígono	que	representa a Região	Metropolitana de João Pessoa formada pelos municípios:
Bayeux, Cabedelo, Conde, Cruz do Espírito Santo, João Pessoa, Lucena, Mamanguape, Rio Tinto e Santa Rita. */

SELECT ST_Union(ARRAY[bayeux.geom, cabedelo.geom, conde.geom, cruz.geom, joaop.geom, lucena.geom, mamanguape.geom, riot.geom, santar.geom]) FROM 
sig.municipios bayeux,
sig.municipios cabedelo,
sig.municipios conde,
sig.municipios cruz,
sig.municipios joaop,
sig.municipios lucena,
sig.municipios mamanguape,
sig.municipios riot,
sig.municipios santar

WHERE
(bayeux.nome_munic = 'Bayeux') AND
(cabedelo.nome_munic = 'Cabedelo') AND
(conde.nome_munic = 'Conde') AND
(cruz.nome_munic = 'Cruz do Espírito Santo') AND
(joaop.nome_munic = 'João Pessoa') AND
(lucena.nome_munic = 'Lucena') AND
(mamanguape.nome_munic = 'Mamanguape') AND
(riot.nome_munic = 'Rio Tinto') AND
(santar.nome_munic = 'Santa Rita');

/* 13- Encontre	todas os Postoslocalizadas nos municípios de Patos, Sousa e Cajazeiras */
SELECT posto AS postos
FROM
(SELECT posto.estacao AS posto, ST_Contains(cidade_a.geom,posto.geom) AS contains
FROM sig.municipios cidade_a, sig.postos posto WHERE (cidade_a.nome_munic = 'Patos') OR (cidade_a.nome_munic = 'Sousa') OR (cidade_a.nome_munic = 'Cajazeiras')) AS consulta_postos WHERE consulta_postos.contains = true;

/* 14- Encontre	todos os Postos localizadas fora da cidade de Cabedelo */
SELECT posto AS postos
FROM
(SELECT posto.estacao AS posto, ST_Contains(cidade_a.geom,posto.geom) AS contains
FROM sig.municipios cidade_a, sig.postos posto WHERE cidade_a.nome_munic = 'Cabedelo') AS consulta_postos WHERE consulta_postos.contains = false;

/* 15- Mostre todos os	municípios que não são vizinhos	de João	Pessoa. */
SELECT cidade 
FROM
(SELECT cidade_b.nome_munic AS cidade, ST_Touches(cidade_a.geom,cidade_b.geom) AS touches
FROM sig.municipios cidade_a, sig.municipios cidade_b WHERE cidade_a.nome_munic = 'João Pessoa') AS consulta_vizinhos WHERE consulta_vizinhos.touches = false;

/* 16- Mostre os	açudes que estão no município de Campina Grande.
Foi considerado açudes que estão inteiramente dentro do poligono de Campina Grande, a consulta resulta em apenas um resultado mas o mesmo esta com o nome " " então colocamos também o ID do mesmo*/
SELECT acude, acudeid AS id
FROM
(SELECT acude.nome AS acude, acude.gid AS acudeid, ST_Contains(cidade_a.geom,acude.geom) AS contains
FROM sig.municipios cidade_a, sig.acudagem_principal acude WHERE cidade_a.nome_munic = 'Campina Grande') AS consulta_contains WHERE consulta_contains.contains = true;

/* 17- Retorne o MBR do açude Epitácio Pessoa (Boqueirão). */
SELECT ST_Envelope(acude.geom) FROM sig.acudagem_principal acude WHERE acude.nome = 'Aç. Epitácio Pessoa';

/* 18- Quais municípios	interceptam o açude Epitácio Pessoa? */
SELECT cidade
FROM
(SELECT cidade_a.nome_munic AS cidade, ST_Crosses(acude.geom,cidade_a.geom) AS crosses
FROM sig.municipios cidade_a, sig.acudagem_principal acude WHERE acude.nome = 'Aç. Epitácio Pessoa') AS consulta_atravessa WHERE consulta_atravessa.crosses = true;