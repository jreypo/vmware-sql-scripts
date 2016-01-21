/* Crear la BD */

USE [master]
GO
CREATE DATABASE [vcloud] ON PRIMARY
(NAME = N'vcloud', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\vcloud.mdf', SIZE = 100MB, FILEGROWTH = 10% )
LOG ON
(NAME = N'vcloud_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\vcloud.ldf', SIZE = 1MB, FILEGROWTH = 10%)
COLLATE Latin1_General_CS_AS
GO

/* transaction isolation level */

USE [vcloud]
GO
ALTER DATABASE [vcloud] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [vcloud] SET ALLOW_SNAPSHOT_ISOLATION ON;
EXEC sp_addextendedproperty @name = N'ALLOW_SNAPSHOT_ISOLATION', @value = 'ON';
ALTER DATABASE [vcloud] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT;
EXEC sp_addextendedproperty @name = N'READ_COMMITTED_SNAPSHOT', @value = 'ON';
ALTER DATABASE [vcloud] SET MULTI_USER;
GO

/* crear usuario */
USE [vcloud]
GO
CREATE LOGIN [vcloud] WITH PASSWORD = 'VMware1!', DEFAULT_DATABASE =[vcloud],
   DEFAULT_LANGUAGE =[us_english], CHECK_POLICY=OFF
GO
CREATE USER [vcloud] for LOGIN [vcloud]
GO

/* asignar permisos */

USE [vcloud]
GO
sp_addrolemember [db_owner], [vcloud]
GO
