CREATE PROCEDURE [exec_send_service_partner]
AS
BEGIN
    -- Definir vari�veis com os nomes da pasta, projeto e pacote
    DECLARE @folder_name NVARCHAR(128) = 'folder';
    DECLARE @project_name NVARCHAR(128) = 'ETL';
    DECLARE @package_name NVARCHAR(260) = '.dtsx';

    -- Declarar vari�vel para o ID da execu��o
    DECLARE @execution_id BIGINT;

    -- Criar uma execu��o
    EXEC [SSISDB].[catalog].[create_execution]
        @folder_name = @folder_name,
        @project_name = @project_name,
        @package_name = @package_name,
        @use32bitruntime = False,
        @reference_id = NULL,
        @execution_id = @execution_id OUTPUT;

    -- Iniciar a execu��o
    EXEC [SSISDB].[catalog].[start_execution] @execution_id;
END


EXEC [exec_send_service_partner]