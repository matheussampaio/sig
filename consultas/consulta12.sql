/*12- Monte	o	polígono	que	representa	a	Região	Metropolitana	de	João	Pessoa formada	pelos	municípios:
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
(santar.nome_munic = 'Santa Rita')