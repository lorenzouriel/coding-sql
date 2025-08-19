-- Inicio da Semana 
EXECUTE dbo.DatabaseBackup
@Databases = 'waves', -- Seu Banco de Dados (USER_DATABASES faz backup de todos)
@Directory = 'C:\Backup', -- Diret�rio que quer salvar
@BackupType = 'FULL', -- Tipo de Backup (FULL/DIFF/LOG)
@Compress = 'Y', -- Realiza uma compressao (Reduz o tamanho do arquivo)
@CheckSum = 'Y', -- Verifica se deu tudo certo (Nada foi corrompido)
@CleanupMode = 'BEFORE_BACKUP' -- Apaga os Backups antigos para nao encher o disco

-- Final de cada dia
EXECUTE dbo.DatabaseBackup
@Databases = 'waves', -- Seu Banco de Dados (USER_DATABASES faz backup de todos)
@Directory = 'C:\Backup', -- Diret�rio que quer salvar
@BackupType = 'DIFF', -- Tipo de Backup (FULL/DIFF/LOG)
@ChangeBackupType = 'Y', -- Caso der erro mude o tipo de Backup (Quest�o de seguran�a)
@CleanupMode = 'BEFORE_BACKUP' -- Apaga os Backups antigos para n�o encher � armazenamento


-- A cada hora
EXECUTE dbo.DatabaseBackup
@Databases = 'waves', -- Seu Banco de Dados (USER_DATABASES faz backup de todos)
@Directory = 'C:\Backup', -- Diret�rio que quer salvar
@BackupType = 'LOG', -- Tipo de Backup (FULL/DIFF/LOG)
@LogSizeSinceLastLogBackup = 1024, -- Especifique um tamanho minimo (MB) para a quantidade de log gerada desde o �ltimo backup de log.
@TimeSinceLastLogBackup = 300, -- Especifique um tempo minimo, em segundos, desde o �ltimo backup de log.
@CleanupMode = 'BEFORE_BACKUP' -- Apaga os Backups antigos para n�o encher o armazenamento
