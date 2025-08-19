
DECLARE @Sq geometry  = 
geometry::STGeomFromText('LINESTRING (10 10, 10 100, 100 100, 100 10, 10 10)', 0);
SELECT @Sq


DECLARE @circle geometry  
= geometry::Parse('CIRCULARSTRING(3 2, 2 3, 1 2, 2 1, 3 2)');  
select @circle


DECLARE @Tri geometry 
=  geometry::STGeomFromText('POLYGON((100 100,200 300,300 100, 100 100))', 0);
select @Tri


DECLARE @Sqfilled geometry 
= geometry::STGeomFromText('POLYGON((10 10, 10 100, 100 100, 100 10, 10 10))', 0);
SELECT @Sqfilled


[position]  AS ([geography]::Point([latitude],[longitude],(4326))) PERSISTED NOT NULL,


DECLARE @Sq geometry 
= geometry::STGeomFromText('POLYGON((15 15, 15 250, 250 250, 250 15, 15 15))', 0),
@Tri geometry 
= geometry::STGeomFromText('POLYGON((100 100,200 300,300 100, 100 100))', 0);
 
SELECT @Sq
UNION ALL
SELECT @Tri