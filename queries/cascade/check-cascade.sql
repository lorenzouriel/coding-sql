SELECT 
    fk.name AS 'Nome_Constraint',
    tp.name AS 'Tabela_Pai',
    rf.name AS 'Coluna_Pai',
    tr.name AS 'Tabela_Filha',
    ff.name AS 'Coluna_Filha',
    fk.update_referential_action_desc AS 'Regra_Atualizacao',
    fk.delete_referential_action_desc AS 'Regra_Exclusao'
FROM 
    sys.foreign_keys AS fk
    INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.columns AS rf ON fk.parent_object_id = rf.object_id --AND fk.constraint_column_id = rf.column_id
    INNER JOIN sys.tables AS tr ON fk.referenced_object_id = tr.object_id
    INNER JOIN sys.columns AS ff ON fk.referenced_object_id = ff.object_id --AND fk.constraint_column_id = ff.column_id;
WHERE tp.[name] = 'user_id'