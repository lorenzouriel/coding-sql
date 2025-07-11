EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'min server memory (MB)';
EXEC sp_configure 'max server memory (MB)';

-- Check actual memory
SELECT 
    total_physical_memory_kb / 1024 AS total_physical_memory_MB,
    available_physical_memory_kb / 1024 AS available_physical_memory_MB,
    total_page_file_kb / 1024 AS total_page_file_MB,
    available_page_file_kb / 1024 AS available_page_file_MB,
    system_memory_state_desc
FROM sys.dm_os_sys_memory;

-- Change memory
EXEC sp_configure 'max server memory (MB)', 4096;
RECONFIGURE;

EXEC sp_configure 'min server memory (MB)', 1024;
RECONFIGURE;