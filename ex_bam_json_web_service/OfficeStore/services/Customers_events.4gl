#+ JSON Web service - Events Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

IMPORT FGL libdbappEvents
IMPORT FGL Customers_common
IMPORT FGL Customers

-- Database schema
SCHEMA officestore

-- EVENTS
PUBLIC DEFINE m_DlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type

-- DATA EVENT FUNCTION TYPES
-- DATA EVENT FUNCTION TYPES - ROW LEVEL
PUBLIC TYPE T_DataEvent_Accounts_OnSelectRows FUNCTION(sqlSelect STRING, sqlFrom STRING, sqlWhere STRING, sqlOrderBy STRING) RETURNS (STRING)
PUBLIC TYPE T_DataEvent_Accounts_OnComputedFields FUNCTION(currentRow Accounts_br_type INOUT)

PUBLIC TYPE T_DataEvent_Accounts_BeforeInsertRow FUNCTION(dataInsert RECORD LIKE account.*) RETURNS (INTEGER, STRING, RECORD LIKE account.*)
PUBLIC TYPE T_DataEvent_Accounts_AfterInsertRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Accounts_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_Accounts_BeforeUpdateRow FUNCTION(p_dataT0 RECORD LIKE account.*, p_dataT1 RECORD LIKE account.*) RETURNS (INTEGER, STRING, RECORD LIKE account.*, RECORD LIKE account.*)
PUBLIC TYPE T_DataEvent_Accounts_AfterUpdateRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Accounts_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_Accounts_BeforeDeleteRow FUNCTION(uniqueKey Accounts_br_uk_type) RETURNS (INTEGER, STRING, Accounts_br_uk_type)
PUBLIC TYPE T_DataEvent_Accounts_AfterDeleteRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Accounts_br_uk_type) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DataEvent_Orders_OnSelectRows FUNCTION(sqlSelect STRING, sqlFrom STRING, sqlWhere STRING, sqlOrderBy STRING) RETURNS (STRING)
PUBLIC TYPE T_DataEvent_Orders_OnComputedFields FUNCTION(currentRow Orders_br_type INOUT)

PUBLIC TYPE T_DataEvent_Orders_BeforeInsertRow FUNCTION(dataInsert RECORD LIKE orders.*) RETURNS (INTEGER, STRING, RECORD LIKE orders.*)
PUBLIC TYPE T_DataEvent_Orders_AfterInsertRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Orders_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_Orders_BeforeUpdateRow FUNCTION(p_dataT0 RECORD LIKE orders.*, p_dataT1 RECORD LIKE orders.*) RETURNS (INTEGER, STRING, RECORD LIKE orders.*, RECORD LIKE orders.*)
PUBLIC TYPE T_DataEvent_Orders_AfterUpdateRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Orders_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_Orders_BeforeDeleteRow FUNCTION(uniqueKey Orders_br_uk_type) RETURNS (INTEGER, STRING, Orders_br_uk_type)
PUBLIC TYPE T_DataEvent_Orders_AfterDeleteRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey Orders_br_uk_type) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DataEvent_LineItems_OnSelectRows FUNCTION(sqlSelect STRING, sqlFrom STRING, sqlWhere STRING, sqlOrderBy STRING) RETURNS (STRING)
PUBLIC TYPE T_DataEvent_LineItems_OnComputedFields FUNCTION(currentRow LineItems_br_type INOUT)

PUBLIC TYPE T_DataEvent_LineItems_BeforeInsertRow FUNCTION(dataInsert RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING, RECORD LIKE lineitem.*)
PUBLIC TYPE T_DataEvent_LineItems_AfterInsertRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey LineItems_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_LineItems_BeforeUpdateRow FUNCTION(p_dataT0 RECORD LIKE lineitem.*, p_dataT1 RECORD LIKE lineitem.*) RETURNS (INTEGER, STRING, RECORD LIKE lineitem.*, RECORD LIKE lineitem.*)
PUBLIC TYPE T_DataEvent_LineItems_AfterUpdateRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey LineItems_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_LineItems_BeforeDeleteRow FUNCTION(uniqueKey LineItems_br_uk_type) RETURNS (INTEGER, STRING, LineItems_br_uk_type)
PUBLIC TYPE T_DataEvent_LineItems_AfterDeleteRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey LineItems_br_uk_type) RETURNS (INTEGER, STRING)

-- DATA EVENT FUNCTION VARIABLES
-- DATA EVENT FUNCTION VARIABLES - ROW LEVEL

PUBLIC DEFINE m_DataEvent_Accounts_OnSelectRows T_DataEvent_Accounts_OnSelectRows
PUBLIC DEFINE m_DataEvent_Accounts_OnComputedFields T_DataEvent_Accounts_OnComputedFields

PUBLIC DEFINE m_DataEvent_Accounts_BeforeInsertRow T_DataEvent_Accounts_BeforeInsertRow
PUBLIC DEFINE m_DataEvent_Accounts_AfterInsertRow T_DataEvent_Accounts_AfterInsertRow

PUBLIC DEFINE m_DataEvent_Accounts_BeforeUpdateRow T_DataEvent_Accounts_BeforeUpdateRow
PUBLIC DEFINE m_DataEvent_Accounts_AfterUpdateRow T_DataEvent_Accounts_AfterUpdateRow

PUBLIC DEFINE m_DataEvent_Accounts_BeforeDeleteRow T_DataEvent_Accounts_BeforeDeleteRow
PUBLIC DEFINE m_DataEvent_Accounts_AfterDeleteRow T_DataEvent_Accounts_AfterDeleteRow

PUBLIC DEFINE m_DataEvent_Orders_OnSelectRows T_DataEvent_Orders_OnSelectRows
PUBLIC DEFINE m_DataEvent_Orders_OnComputedFields T_DataEvent_Orders_OnComputedFields

PUBLIC DEFINE m_DataEvent_Orders_BeforeInsertRow T_DataEvent_Orders_BeforeInsertRow
PUBLIC DEFINE m_DataEvent_Orders_AfterInsertRow T_DataEvent_Orders_AfterInsertRow

PUBLIC DEFINE m_DataEvent_Orders_BeforeUpdateRow T_DataEvent_Orders_BeforeUpdateRow
PUBLIC DEFINE m_DataEvent_Orders_AfterUpdateRow T_DataEvent_Orders_AfterUpdateRow

PUBLIC DEFINE m_DataEvent_Orders_BeforeDeleteRow T_DataEvent_Orders_BeforeDeleteRow
PUBLIC DEFINE m_DataEvent_Orders_AfterDeleteRow T_DataEvent_Orders_AfterDeleteRow

PUBLIC DEFINE m_DataEvent_LineItems_OnSelectRows T_DataEvent_LineItems_OnSelectRows
PUBLIC DEFINE m_DataEvent_LineItems_OnComputedFields T_DataEvent_LineItems_OnComputedFields

PUBLIC DEFINE m_DataEvent_LineItems_BeforeInsertRow T_DataEvent_LineItems_BeforeInsertRow
PUBLIC DEFINE m_DataEvent_LineItems_AfterInsertRow T_DataEvent_LineItems_AfterInsertRow

PUBLIC DEFINE m_DataEvent_LineItems_BeforeUpdateRow T_DataEvent_LineItems_BeforeUpdateRow
PUBLIC DEFINE m_DataEvent_LineItems_AfterUpdateRow T_DataEvent_LineItems_AfterUpdateRow

PUBLIC DEFINE m_DataEvent_LineItems_BeforeDeleteRow T_DataEvent_LineItems_BeforeDeleteRow
PUBLIC DEFINE m_DataEvent_LineItems_AfterDeleteRow T_DataEvent_LineItems_AfterDeleteRow

-- REGISTER EVENT FUNCTIONS
PUBLIC FUNCTION Customers_registerDlgEvents()
    -- REGISTER DATA EVENT FUNCTIONS - ROW LEVEL

END FUNCTION
