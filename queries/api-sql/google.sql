CREATE  FUNCTION [dbo].[google_data](
	@address varchar(1000),
	@limit int = 1
)
returns @table table(latitude float,longitude float, address nvarchar(1000))
WITH EXECUTE AS OWNER
AS
BEGIN 
	declare @result nvarchar(1000)
	declare @url nvarchar(max) = 
		concat(
			'http://google.com.br/?format=json&addressdetails=0&q=',
			 @address COLLATE SQL_Latin1_General_CP1253_CI_AI,
			 '&format=json&limit=',
			 cast(@limit as varchar(2)))

	DECLARE @Object as Int;
	DECLARE @ResponseText as Varchar(8000);

	EXEC sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
	Exec sp_OAMethod @Object, 'open', NULL, 'get',
					 @url,
					 'false'
	Exec sp_OAMethod @Object, 'send'
	Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
	Exec sp_OADestroy @Object
	--SELECT @result = display_name
	--	FROM OPENJSON(@ResponseText) with (
	--		display_name nvarchar(max) '$.display_name'
			
	--	);
	insert into @table (latitude, longitude, address)
	SELECT latitude, longitude, display_name --road + ', ' + suburb + ', ' + city + ', ' + state + ', ' + country
	FROM OPENJSON(@ResponseText) with (
		latitude float '$.lat',
		longitude float '$.lon',
		display_name nvarchar(max) '$.display_name',
		road nvarchar(max) '$.address.road',
		neighbourhood nvarchar(max) '$.address.neighbourhood',
		suburb nvarchar(max) '$.address.suburb',
			--"city_district": "Santo Andr�",
		city nvarchar(max) '$.address.city',
			--"county": "Regi�o Imediata de S�o Paulo",
			--"state_district": "Regi�o Intermedi�ria de S�o Paulo",
		state nvarchar(max) '$.address.city',
		postcode nvarchar(max) '$.address.postcode',
		country nvarchar(max) '$.address.country'
			--"country_code": "br"
	);

	return

end
GO


