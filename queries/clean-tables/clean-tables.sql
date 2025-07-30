-- Ativa QUOTED_IDENTIFIER
SET QUOTED_IDENTIFIER ON;

-- Desabilita constraints
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Executa DELETE
EXEC sp_msforeachtable '
    SET QUOTED_IDENTIFIER ON;
    DELETE FROM ?;
';

-- Reabilita constraints
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
