-- Get the point in question

declare @scb0 geography = geography::STGeomFromText('POINT(-90.851758 44.292658)',4326);

-- buffer that by 50 metres, resulting shape is circular

set @scb0 = @scb0.STBuffer(50);

-- convert to a geometry instance

declare @scb1 geometry = geometry::STGeomFromText(@scb0.ToString(),4326);

-- convert to an MBR

set @scb1 = @scb1.STEnvelope();

-- convert back to a geography

set @scb0 = geography::STGeomFromText(@scb1.ToString(),4326);

select @scb0;


-- One Line
select geography:: Point(45, -90, 4326).BufferWithTolerance(11000, 1000, 0)