/*
==========================================================================
Quality Checks
==========================================================================
Script Purpose:
	  This script performs various quality check for data consistency, accuracy, 
    and standardization across the ’silver’ schemas. It includes checks for:
      -	Null or duplicates primary keys.
      -	Unwanted spaces in string fields.
      -	Data standardization and consistency.
      -	Invalid Date ranges and others.
      -	Data consistency between related fields

Usage Notes:
      -	Run these checks after data loading Silver Layer.
      -	Investigate and resolve any discrepancies found during the checks.
==========================================================================
*/

/*==============================================
--Checking: silver.crm_cust_info
===============================================*/
SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT DISTINCT cst_material_status
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info

/*==============================================
--Checking: silver.crm_prd_info
===============================================*/
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

SELECT DISTINCT prd_line
FROM silver.crm_prd_info

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
FROM silver.crm_prd_info

/*==============================================
--Checking: silver.crm_sales_details
===============================================*/
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

SELECT DISTINCT 
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price

SELECT * FROM silver.crm_sales_details
/*==============================================
--Checking: silver.erp_cust_az12
===============================================*/
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

SELECT DISTINCT
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM silver.erp_cust_az12

SELECT * FROM silver.erp_cust_az12

/*==============================================
--Checking: silver.erp_loc_a101
===============================================*/
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry

SELECT * FROM silver.erp_loc_a101

/*==============================================
--Checking: silver.erp_px_cat_g1v2
===============================================*/
SELECT DISTINCT cat
FROM silver.erp_px_cat_g1v2

SELECT DISTINCT subcat
FROM silver.erp_px_cat_g1v2

SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2


SELECT * FROM silver.erp_px_cat_g1v2
