use [master]
exec sp_dropdistributor @no_checks=1, @ignore_distributor=1


use [master]
exec sp_dropdistributor @no_checks=1
go