#+ DB schema - Events Management (officestore)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

IMPORT FGL officestore_common
IMPORT FGL officestore

-- Database schema
SCHEMA officestore

-- DATABASE EVENT FUNCTION TYPES - TABLE LEVEL
PUBLIC TYPE T_DbxDataEvent_supplier_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE supplier.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_supplier_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE supplier.*) RETURNS (INTEGER, STRING, RECORD LIKE supplier.*)
PUBLIC TYPE T_DbxDataEvent_supplier_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE supplier.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_supplier_BeforeDeleteRowByKey FUNCTION(p_key supplier_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_supplier_AfterDeleteRowByKey FUNCTION(p_key supplier_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_supplier_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE supplier.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_supplier_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE supplier.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_supplier_SetDefaultValues FUNCTION(p_data RECORD LIKE supplier.*) RETURNS (RECORD LIKE supplier.*)

PUBLIC TYPE T_DbxDataEvent_signon_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE signon.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_signon_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE signon.*) RETURNS (INTEGER, STRING, RECORD LIKE signon.*)
PUBLIC TYPE T_DbxDataEvent_signon_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE signon.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_signon_BeforeDeleteRowByKey FUNCTION(p_key signon_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_signon_AfterDeleteRowByKey FUNCTION(p_key signon_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_signon_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE signon.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_signon_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE signon.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_signon_SetDefaultValues FUNCTION(p_data RECORD LIKE signon.*) RETURNS (RECORD LIKE signon.*)

PUBLIC TYPE T_DbxDataEvent_seqreg_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING, RECORD LIKE seqreg.*)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeDeleteRowByKey FUNCTION(p_key seqreg_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterDeleteRowByKey FUNCTION(p_key seqreg_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_seqreg_SetDefaultValues FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (RECORD LIKE seqreg.*)

PUBLIC TYPE T_DbxDataEvent_product_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE product.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_product_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE product.*) RETURNS (INTEGER, STRING, RECORD LIKE product.*)
PUBLIC TYPE T_DbxDataEvent_product_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE product.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_product_BeforeDeleteRowByKey FUNCTION(p_key product_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_product_AfterDeleteRowByKey FUNCTION(p_key product_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_product_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE product.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_product_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE product.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_product_SetDefaultValues FUNCTION(p_data RECORD LIKE product.*) RETURNS (RECORD LIKE product.*)

PUBLIC TYPE T_DbxDataEvent_orderstatus_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE orderstatus.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orderstatus_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE orderstatus.*) RETURNS (INTEGER, STRING, RECORD LIKE orderstatus.*)
PUBLIC TYPE T_DbxDataEvent_orderstatus_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE orderstatus.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orderstatus_BeforeDeleteRowByKey FUNCTION(p_key orderstatus_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_orderstatus_AfterDeleteRowByKey FUNCTION(p_key orderstatus_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_orderstatus_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE orderstatus.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orderstatus_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE orderstatus.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_orderstatus_SetDefaultValues FUNCTION(p_data RECORD LIKE orderstatus.*) RETURNS (RECORD LIKE orderstatus.*)

PUBLIC TYPE T_DbxDataEvent_orders_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE orders.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orders_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE orders.*) RETURNS (INTEGER, STRING, RECORD LIKE orders.*)
PUBLIC TYPE T_DbxDataEvent_orders_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE orders.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orders_BeforeDeleteRowByKey FUNCTION(p_key orders_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_orders_AfterDeleteRowByKey FUNCTION(p_key orders_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_orders_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE orders.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_orders_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE orders.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_orders_SetDefaultValues FUNCTION(p_data RECORD LIKE orders.*) RETURNS (RECORD LIKE orders.*)

PUBLIC TYPE T_DbxDataEvent_lineitem_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_lineitem_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING, RECORD LIKE lineitem.*)
PUBLIC TYPE T_DbxDataEvent_lineitem_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_lineitem_BeforeDeleteRowByKey FUNCTION(p_key lineitem_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_lineitem_AfterDeleteRowByKey FUNCTION(p_key lineitem_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_lineitem_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_lineitem_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_lineitem_SetDefaultValues FUNCTION(p_data RECORD LIKE lineitem.*) RETURNS (RECORD LIKE lineitem.*)

PUBLIC TYPE T_DbxDataEvent_item_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE item.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_item_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE item.*) RETURNS (INTEGER, STRING, RECORD LIKE item.*)
PUBLIC TYPE T_DbxDataEvent_item_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE item.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_item_BeforeDeleteRowByKey FUNCTION(p_key item_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_item_AfterDeleteRowByKey FUNCTION(p_key item_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_item_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE item.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_item_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE item.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_item_SetDefaultValues FUNCTION(p_data RECORD LIKE item.*) RETURNS (RECORD LIKE item.*)

PUBLIC TYPE T_DbxDataEvent_inventory_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE inventory.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_inventory_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE inventory.*) RETURNS (INTEGER, STRING, RECORD LIKE inventory.*)
PUBLIC TYPE T_DbxDataEvent_inventory_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE inventory.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_inventory_BeforeDeleteRowByKey FUNCTION(p_key inventory_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_inventory_AfterDeleteRowByKey FUNCTION(p_key inventory_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_inventory_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE inventory.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_inventory_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE inventory.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_inventory_SetDefaultValues FUNCTION(p_data RECORD LIKE inventory.*) RETURNS (RECORD LIKE inventory.*)

PUBLIC TYPE T_DbxDataEvent_country_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE country.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_country_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE country.*) RETURNS (INTEGER, STRING, RECORD LIKE country.*)
PUBLIC TYPE T_DbxDataEvent_country_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE country.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_country_BeforeDeleteRowByKey FUNCTION(p_key country_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_country_AfterDeleteRowByKey FUNCTION(p_key country_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_country_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE country.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_country_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE country.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_country_SetDefaultValues FUNCTION(p_data RECORD LIKE country.*) RETURNS (RECORD LIKE country.*)

PUBLIC TYPE T_DbxDataEvent_category_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE category.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_category_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE category.*) RETURNS (INTEGER, STRING, RECORD LIKE category.*)
PUBLIC TYPE T_DbxDataEvent_category_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE category.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_category_BeforeDeleteRowByKey FUNCTION(p_key category_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_category_AfterDeleteRowByKey FUNCTION(p_key category_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_category_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE category.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_category_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE category.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_category_SetDefaultValues FUNCTION(p_data RECORD LIKE category.*) RETURNS (RECORD LIKE category.*)

PUBLIC TYPE T_DbxDataEvent_account_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE account.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_account_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE account.*) RETURNS (INTEGER, STRING, RECORD LIKE account.*)
PUBLIC TYPE T_DbxDataEvent_account_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE account.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_account_BeforeDeleteRowByKey FUNCTION(p_key account_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_account_AfterDeleteRowByKey FUNCTION(p_key account_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_account_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE account.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_account_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE account.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_account_SetDefaultValues FUNCTION(p_data RECORD LIKE account.*) RETURNS (RECORD LIKE account.*)

-- DATABASE EVENT FUNCTION VARIABLES - TABLE LEVEL

PUBLIC DEFINE m_DbxDataEvent_supplier_CheckTableConstraints T_DbxDataEvent_supplier_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_supplier_BeforeInsertRowByKey T_DbxDataEvent_supplier_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_supplier_AfterInsertRowByKey T_DbxDataEvent_supplier_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_supplier_BeforeDeleteRowByKey T_DbxDataEvent_supplier_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_supplier_AfterDeleteRowByKey T_DbxDataEvent_supplier_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_supplier_BeforeUpdateRowByKey T_DbxDataEvent_supplier_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_supplier_AfterUpdateRowByKey T_DbxDataEvent_supplier_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_supplier_SetDefaultValues T_DbxDataEvent_supplier_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_signon_CheckTableConstraints T_DbxDataEvent_signon_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_signon_BeforeInsertRowByKey T_DbxDataEvent_signon_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_signon_AfterInsertRowByKey T_DbxDataEvent_signon_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_signon_BeforeDeleteRowByKey T_DbxDataEvent_signon_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_signon_AfterDeleteRowByKey T_DbxDataEvent_signon_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_signon_BeforeUpdateRowByKey T_DbxDataEvent_signon_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_signon_AfterUpdateRowByKey T_DbxDataEvent_signon_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_signon_SetDefaultValues T_DbxDataEvent_signon_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_seqreg_CheckTableConstraints T_DbxDataEvent_seqreg_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeInsertRowByKey T_DbxDataEvent_seqreg_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterInsertRowByKey T_DbxDataEvent_seqreg_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeDeleteRowByKey T_DbxDataEvent_seqreg_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterDeleteRowByKey T_DbxDataEvent_seqreg_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeUpdateRowByKey T_DbxDataEvent_seqreg_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterUpdateRowByKey T_DbxDataEvent_seqreg_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_seqreg_SetDefaultValues T_DbxDataEvent_seqreg_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_product_CheckTableConstraints T_DbxDataEvent_product_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_product_BeforeInsertRowByKey T_DbxDataEvent_product_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_product_AfterInsertRowByKey T_DbxDataEvent_product_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_product_BeforeDeleteRowByKey T_DbxDataEvent_product_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_product_AfterDeleteRowByKey T_DbxDataEvent_product_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_product_BeforeUpdateRowByKey T_DbxDataEvent_product_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_product_AfterUpdateRowByKey T_DbxDataEvent_product_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_product_SetDefaultValues T_DbxDataEvent_product_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_orderstatus_CheckTableConstraints T_DbxDataEvent_orderstatus_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_orderstatus_BeforeInsertRowByKey T_DbxDataEvent_orderstatus_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_orderstatus_AfterInsertRowByKey T_DbxDataEvent_orderstatus_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_orderstatus_BeforeDeleteRowByKey T_DbxDataEvent_orderstatus_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_orderstatus_AfterDeleteRowByKey T_DbxDataEvent_orderstatus_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_orderstatus_BeforeUpdateRowByKey T_DbxDataEvent_orderstatus_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_orderstatus_AfterUpdateRowByKey T_DbxDataEvent_orderstatus_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_orderstatus_SetDefaultValues T_DbxDataEvent_orderstatus_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_orders_CheckTableConstraints T_DbxDataEvent_orders_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_orders_BeforeInsertRowByKey T_DbxDataEvent_orders_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_orders_AfterInsertRowByKey T_DbxDataEvent_orders_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_orders_BeforeDeleteRowByKey T_DbxDataEvent_orders_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_orders_AfterDeleteRowByKey T_DbxDataEvent_orders_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_orders_BeforeUpdateRowByKey T_DbxDataEvent_orders_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_orders_AfterUpdateRowByKey T_DbxDataEvent_orders_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_orders_SetDefaultValues T_DbxDataEvent_orders_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_lineitem_CheckTableConstraints T_DbxDataEvent_lineitem_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_lineitem_BeforeInsertRowByKey T_DbxDataEvent_lineitem_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_lineitem_AfterInsertRowByKey T_DbxDataEvent_lineitem_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_lineitem_BeforeDeleteRowByKey T_DbxDataEvent_lineitem_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_lineitem_AfterDeleteRowByKey T_DbxDataEvent_lineitem_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_lineitem_BeforeUpdateRowByKey T_DbxDataEvent_lineitem_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_lineitem_AfterUpdateRowByKey T_DbxDataEvent_lineitem_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_lineitem_SetDefaultValues T_DbxDataEvent_lineitem_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_item_CheckTableConstraints T_DbxDataEvent_item_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_item_BeforeInsertRowByKey T_DbxDataEvent_item_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_item_AfterInsertRowByKey T_DbxDataEvent_item_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_item_BeforeDeleteRowByKey T_DbxDataEvent_item_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_item_AfterDeleteRowByKey T_DbxDataEvent_item_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_item_BeforeUpdateRowByKey T_DbxDataEvent_item_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_item_AfterUpdateRowByKey T_DbxDataEvent_item_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_item_SetDefaultValues T_DbxDataEvent_item_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_inventory_CheckTableConstraints T_DbxDataEvent_inventory_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_inventory_BeforeInsertRowByKey T_DbxDataEvent_inventory_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_inventory_AfterInsertRowByKey T_DbxDataEvent_inventory_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_inventory_BeforeDeleteRowByKey T_DbxDataEvent_inventory_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_inventory_AfterDeleteRowByKey T_DbxDataEvent_inventory_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_inventory_BeforeUpdateRowByKey T_DbxDataEvent_inventory_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_inventory_AfterUpdateRowByKey T_DbxDataEvent_inventory_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_inventory_SetDefaultValues T_DbxDataEvent_inventory_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_country_CheckTableConstraints T_DbxDataEvent_country_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_country_BeforeInsertRowByKey T_DbxDataEvent_country_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_country_AfterInsertRowByKey T_DbxDataEvent_country_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_country_BeforeDeleteRowByKey T_DbxDataEvent_country_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_country_AfterDeleteRowByKey T_DbxDataEvent_country_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_country_BeforeUpdateRowByKey T_DbxDataEvent_country_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_country_AfterUpdateRowByKey T_DbxDataEvent_country_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_country_SetDefaultValues T_DbxDataEvent_country_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_category_CheckTableConstraints T_DbxDataEvent_category_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_category_BeforeInsertRowByKey T_DbxDataEvent_category_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_category_AfterInsertRowByKey T_DbxDataEvent_category_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_category_BeforeDeleteRowByKey T_DbxDataEvent_category_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_category_AfterDeleteRowByKey T_DbxDataEvent_category_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_category_BeforeUpdateRowByKey T_DbxDataEvent_category_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_category_AfterUpdateRowByKey T_DbxDataEvent_category_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_category_SetDefaultValues T_DbxDataEvent_category_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_account_CheckTableConstraints T_DbxDataEvent_account_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_account_BeforeInsertRowByKey T_DbxDataEvent_account_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_account_AfterInsertRowByKey T_DbxDataEvent_account_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_account_BeforeDeleteRowByKey T_DbxDataEvent_account_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_account_AfterDeleteRowByKey T_DbxDataEvent_account_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_account_BeforeUpdateRowByKey T_DbxDataEvent_account_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_account_AfterUpdateRowByKey T_DbxDataEvent_account_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_account_SetDefaultValues T_DbxDataEvent_account_SetDefaultValues

-- REGISTER EVENT FUNCTIONS
PUBLIC FUNCTION officestore_registerDbxEvents()
    -- REGISTER DATABASE EVENT FUNCTIONS - TABLE LEVEL

END FUNCTION
