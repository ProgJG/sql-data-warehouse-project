/*
===========================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===========================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from eternal CSV files.
    It perfoms the following actions:
    - Truncates the bronze tables before loading datat.
    - Uses the 'BULK INSERT' command to load data from CSV files to bronze tables
Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===========================================================================================

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
-- Mennyi időbe tellik amig betölt. Érdemes mérni a futásidőt, megénz, hol megy el sok idő!!
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time =GETDATE();
		PRINT '=====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================';

		PRINT '-------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------';

	/* Tömeges adatbetöltés */

	-- 1. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	--SELECT * FROM bronze.crm_cust_info

	-- Sorok számának egyezését érdemes ellenőrizni:
	--SELECT COUNT(*) FROM bronze.crm_cust_info
	-- ========================================================================

	-- 2. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	--SELECT * FROM bronze.crm_prd_info

	-- Sorok számának egyezését érdemes ellenőrizni:
	--SELECT COUNT(*) FROM bronze.crm_prd_info
	-- ========================================================================

	-- 3. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	--SELECT * FROM bronze.crm_sales_details

	-- Sorok számának egyezését érdemes ellenőrizni:
	--SELECT COUNT(*) FROM bronze.crm_sales_details
	-- ========================================================================

		PRINT '-------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------';

	-- 4. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	--SELECT * FROM bronze.erp_cust_az12

	-- Sorok számának egyezését érdemes ellenőrizni:
	--SELECT COUNT(*) FROM bronze.erp_cust_az12
	-- ========================================================================

	-- 5. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	--SELECT * FROM bronze.erp_loc_a101

	-- Sorok számának egyezését érdemes ellenőrizni:
	--SELECT COUNT(*) FROM bronze.erp_loc_a101
	-- ========================================================================

	-- 6. beolvasás
	-- Beolvasás előtt érdemes a TRUNCATE TABLE-el a dublikációkat kiszűrni!!
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	-- Majd a fentieket követően beolvasni:
		PRINT '>> Inserting Data Into:bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\SQL2025\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
	-- A második sortól vegye figyelembe, mert az első a FEJLÉC!!
			FIRSTROW = 2,
	-- Oszlop elválasztó ebben az esetben a vessző (,)
			FIELDTERMINATOR = ',',
			TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '----------------------------';

	SET @batch_end_time = GETDATE();
	PRINT '======================================'
	PRINT 'Loading Bronze Layer is Completed';
	PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';

	-- SELECT * FROM bronze.erp_px_cat_g1v2

	-- Sorok számának egyezését érdemes ellenőrizni:
	-- SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
END TRY
BEGIN CATCH
	PRINT '======================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '======================================'
END CATCH
END
