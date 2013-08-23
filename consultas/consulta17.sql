/*17- Retorne o MBR do açude Epitácio Pessoa (Boqueirão). */

SELECT ST_Envelope(ST_Transform(acude.geom,29195)) FROM sig.acudagem_principal acude WHERE acude.nome = 'Aç. Epitácio Pessoa'