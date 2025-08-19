-- Cria tabela points
DROP TABLE  IF EXISTS [points]
GO

CREATE TABLE [points]
(
	[Id] int identity, 
	[geog] geography,
	[Geom] as geometry::STGeomFromWKB(geog.STAsBinary(), geog.STSrid)
)
GO

-- Busca percursos

-- Processa e salva os pontos do percurso
DECLARE
@id int = 269559161,
@asset_id int = 40379

Insert into points (geog)  
select 
	[position]
from [datas]
where [asset_id] = @asset_id
and [utc_timestamp] between (select cast(DATEADD(hour, 3, [start_timestamp]) as datetime) from [fact].[tracks] where [id] = @id) 
and (select cast(DATEADD(hour, 3, [end_timestamp]) as datetime) from [fact].[tracks] where [id] = @id)
order by [utc_timestamp] asc
GO


SELECT * FROM [points]

-- desenha o percurso
declare 
	@iterRow int,
	@rowCount int,
	@string varchar(max),
	@x varchar(20),
	@y varchar(20),
	@route geometry

Select 
	@iterRow = 1,
    @rowCount = count(1)
from points

While (@iterRow <= @rowCount)
Begin   
   Select  @x = cast(Geom.STX as varchar(20)),
           @y = cast(Geom.STY as varchar(20))
   From points
   where Id = @iterRow
        
   Set @string = isnull(@string + ',', '') + @x + ' ' + @y

   Set @iterRow += 1
End

Set @string = 'LINESTRING(' + @string + ')';   

set @route = geometry::STLineFromText(@string, 0);


-- Salva na coluna route
update [routes]
set [route] = @route
where [id] = 264202407
-- Apaga tabela points

select [distance] = @route.STLength() 