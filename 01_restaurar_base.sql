/* =========================================================
   Desafío Práctico 2 - DMD941
   Script 01: Restauración de AdventureWorksDW
   Autora: Brenda Lissette Peñate Marroquín (PM252707)
   ========================================================= */

-- 1. Ver los nombres lógicos de los archivos dentro del .bak
--    (cambie la ruta si guardó el archivo en otra carpeta)
RESTORE FILELISTONLY
FROM DISK = N'C:\AdventureWorks\AdventureWorksDW2022.bak';
GO

-- 2. Restaurar la base de datos
--    Reemplace los nombres lógicos por los que mostró el paso 1
RESTORE DATABASE AdventureWorksDW2022
FROM DISK = N'C:\AdventureWorks\AdventureWorksDW2022.bak'
WITH
    MOVE N'AdventureWorksDW2022'     TO N'C:\AdventureWorks\AdventureWorksDW2022.mdf',
    MOVE N'AdventureWorksDW2022_log' TO N'C:\AdventureWorks\AdventureWorksDW2022_log.ldf',
    REPLACE, STATS = 10;
GO

-- 3. Verificar que la base quedó en línea
SELECT name, state_desc, create_date
FROM sys.databases
WHERE name = N'AdventureWorksDW2022';
GO
