ALTER TABLE PontoOnibus ADD CONSTRAINT geometry_valid_check CHECK (GeometryType(geom) = 'POINT');