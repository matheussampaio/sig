Projeto de SIG
====================

Sistema para visualizar o mapa da Paraíba além de algumas outras informações.


Configurando o ambiente
===================


####Instalar o Postgres+Postgis

*TODO*


####Configurar o Postgres

*TODO*


####Criando um Banco de Dados Espacial (EN)

The first step in creating a PostGIS database is to create a simple PostgreSQL database.

```
createdb [yourdatabase]
```

Many of the PostGIS functions are written in the PL/pgSQL procedural language. As such, the next step to create a PostGIS database is to enable the PL/pgSQL language in your new database. This is accomplish by the command

```
createlang plpgsql [yourdatabase]
```

Now load the PostGIS object and function definitions into your database by loading the postgis.sql definitions file (located in [prefix]/share/contrib as specified during the configuration step).

```
psql -d [yourdatabase] -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
```

For a complete set of EPSG coordinate system definition identifiers, you can also load the spatial_ref_sys.sql definitions file and populate the spatial_ref_sys table. This will permit you to perform ST_Transform() operations on geometries.

```
psql -d [yourdatabase] -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql 
```

If you wish to add comments to the PostGIS functions, the final step is to load the postgis_comments.sql into your spatial database. The comments can be viewed by simply typing \dd [function_name] from a psql terminal window.

```
psql -d [yourdatabase] -f /usr/share/postgresql/9.1/contrib/postgis_comments.sql 
```
Mais [infos][2].


####Importar os shapefiles da Paraíba

Execute os scripts em *script/* através do pgadmin3


####Instalar o GeoServer

- Instalar o tomcat7:
```
    sudo apt-get install tomcat7
```
- Download do GeoServer [aqui](http://sourceforge.net/projects/geoserver/files/GeoServer/2.3.5/geoserver-2.3.5-war.zip)
- Unzip e copia para */var/lib/tomcat7/webapps/*


####Configurar o  GeoServer

- Adicionar o banco de dados no GeoServer
- Criar um workspace com nome "GO"
- Criar e publicar os Layers

That's all folks!

[1]: http://download.geofabrik.de/south-america.html
[2]: http://postgis.refractions.net/documentation/manual-1.5/ch02.html#id418654
