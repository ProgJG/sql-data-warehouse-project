/* Fontos megjegyzés az eleéjére, hogy megnyitáskor tudjam miről szól, milyen adatok találhatóak benne!!
===================================================================
Create Database and Schemas
===================================================================
Script Purpose (CÉLJA):
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exsistsm it is dropped and recreated. Additionally, the script sets up three schemas
  within the database: 'bronze', 'silver', 'gold'.

Warning (FIGYELMEZTETÉS):
  Running this script will drop the entire 'DataWarehouse' database if it exsists.
  All data in the database will be permanently deleted. Proceed with caution and 
  ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database. 
-- Ezzel meg lehet bizonyosodni, hogy van e már hasonló cím elmentve!!
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
  
-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
