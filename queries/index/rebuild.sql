--Basic Rebuild Command
ALTER INDEX PK__active_u__B9BE370F2E7D9F77 ON dim.active_users REBUILD
 
--REBUILD Index with ONLINE OPTION
ALTER INDEX Index_Name ON Table_Name REBUILD WITH(ONLINE=ON) | WITH(ONLINE=ON)
