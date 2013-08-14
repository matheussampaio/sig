SELECT rodovias.codrodov AS nome, sum(st_length(rodovias.geom))
FROM sig.rodovias rodovias
WHERE rodovias.codrodov = 'PB-008' GROUP BY rodovias.codrodov