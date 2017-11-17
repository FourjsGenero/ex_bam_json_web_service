{<CODEFILE Path="Customers.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface - Data Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp4.1
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql

IMPORT FGL officestore_dbxdata
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA officestore

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE Accounts_br_type
    RECORD
        account_userid LIKE account.userid,
        account_firstname LIKE account.firstname,
        account_lastname LIKE account.lastname,
        country_codedesc LIKE country.codedesc,
        account_phone LIKE account.phone,
        account_email LIKE account.email,
        category_catpic LIKE category.catpic
    END RECORD

PUBLIC TYPE Orders_br_type
    RECORD
        orders_orderid LIKE orders.orderid,
        orders_userid LIKE orders.userid,
        orders_orderdate LIKE orders.orderdate,
        orders_shipcountry LIKE orders.shipcountry,
        ship_country_codedesc LIKE country.codedesc,
        orders_billcountry LIKE orders.billcountry,
        bill_country_codedesc LIKE country.codedesc,
        orders_totalprice LIKE orders.totalprice
    END RECORD

PUBLIC TYPE LineItems_br_type
    RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum,
        lineitem_itemid LIKE lineitem.itemid,
        product_prodname LIKE product.prodname,
        lineitem_quantity LIKE lineitem.quantity,
        lineitem_unitprice LIKE lineitem.unitprice
    END RECORD

PUBLIC TYPE Accounts_br_uk_type
    RECORD
        account_userid LIKE account.userid
    END RECORD

PUBLIC TYPE Orders_br_uk_type
    RECORD
        orders_orderid LIKE orders.orderid
    END RECORD

PUBLIC TYPE LineItems_br_uk_type
    RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum
    END RECORD

PUBLIC TYPE Accounts_Orders_br_rel_type
    RECORD
        orders_userid LIKE orders.userid
    END RECORD

PUBLIC TYPE Orders_LineItems_br_rel_type
    RECORD
        lineitem_orderid LIKE lineitem.orderid
    END RECORD

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.Accounts_insertRow">}
#+ Insert a row in the database
#+
#+ @param p_rec_br Business record values to insert
#+
#+ @returnType INTEGER, STRING, RECORD
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, Business Record unique keys
PUBLIC FUNCTION Customers_uidata_Accounts_insertRow(p_rec_br)
    DEFINE p_rec_br Accounts_br_type
    DEFINE dataInsert RECORD LIKE account.*
    DEFINE ret Accounts_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Accounts_insertRow.define">} {</POINT>}

    --Init local data with default values from the DB schema
    CALL officestore_dbxdata.officestore_dbxdata_account_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
    --Set local data with form field values
    LET dataInsert.userid = p_rec_br.account_userid
    LET dataInsert.firstname = p_rec_br.account_firstname
    LET dataInsert.lastname = p_rec_br.account_lastname
    LET dataInsert.phone = p_rec_br.account_phone
    LET dataInsert.email = p_rec_br.account_email
    {<POINT Name="fct.Accounts_insertRow.init">} {</POINT>}

    --Call the database insert row
    CALL officestore_dbxdata.officestore_dbxdata_account_pk_account_insertRowByKey(dataInsert.*) RETURNING errNo, errMsg, ret.account_userid
    LET errMsg = IIF(errNo = ERROR_SUCCESS, C_TXT_INSERT_SUCCESS_MSG, C_TXT_INSERT_FAIL_MSG), errMsg

    {<POINT Name="fct.Accounts_insertRow.user">} {</POINT>}
    RETURN errNo, errMsg, ret.*
END FUNCTION
{</BLOCK>} --fct.Accounts_insertRow
{<BLOCK Name="fct.Orders_insertRow">}
#+ Insert a row in the database
#+
#+ @param p_rec_br Business record values to insert
#+
#+ @returnType INTEGER, STRING, RECORD
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, Business Record unique keys
PUBLIC FUNCTION Customers_uidata_Orders_insertRow(p_rec_br)
    DEFINE p_rec_br Orders_br_type
    DEFINE dataInsert RECORD LIKE orders.*
    DEFINE ret Orders_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Orders_insertRow.define">} {</POINT>}

    --Init local data with default values from the DB schema
    CALL officestore_dbxdata.officestore_dbxdata_orders_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
    --Set local data with form field values
    LET dataInsert.orderid = p_rec_br.orders_orderid
    LET dataInsert.userid = p_rec_br.orders_userid
    LET dataInsert.orderdate = p_rec_br.orders_orderdate
    LET dataInsert.shipcountry = p_rec_br.orders_shipcountry
    LET dataInsert.billcountry = p_rec_br.orders_billcountry
    LET dataInsert.totalprice = p_rec_br.orders_totalprice
    {<POINT Name="fct.Orders_insertRow.init">} {</POINT>}

    --Call the database insert row
    CALL officestore_dbxdata.officestore_dbxdata_orders_pk_orders_insertRowByKey(dataInsert.*) RETURNING errNo, errMsg, ret.orders_orderid
    LET errMsg = IIF(errNo = ERROR_SUCCESS, C_TXT_INSERT_SUCCESS_MSG, C_TXT_INSERT_FAIL_MSG), errMsg

    {<POINT Name="fct.Orders_insertRow.user">} {</POINT>}
    RETURN errNo, errMsg, ret.*
END FUNCTION
{</BLOCK>} --fct.Orders_insertRow
{<BLOCK Name="fct.LineItems_insertRow">}
#+ Insert a row in the database
#+
#+ @param p_rec_br Business record values to insert
#+
#+ @returnType INTEGER, STRING, RECORD
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, Business Record unique keys
PUBLIC FUNCTION Customers_uidata_LineItems_insertRow(p_rec_br)
    DEFINE p_rec_br LineItems_br_type
    DEFINE dataInsert RECORD LIKE lineitem.*
    DEFINE ret LineItems_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.LineItems_insertRow.define">} {</POINT>}

    --Init local data with default values from the DB schema
    CALL officestore_dbxdata.officestore_dbxdata_lineitem_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
    --Set local data with form field values
    LET dataInsert.orderid = p_rec_br.lineitem_orderid
    LET dataInsert.linenum = p_rec_br.lineitem_linenum
    LET dataInsert.itemid = p_rec_br.lineitem_itemid
    LET dataInsert.quantity = p_rec_br.lineitem_quantity
    LET dataInsert.unitprice = p_rec_br.lineitem_unitprice
    {<POINT Name="fct.LineItems_insertRow.init">} {</POINT>}

    --Call the database insert row
    CALL officestore_dbxdata.officestore_dbxdata_lineitem_pk_lineitem_insertRowByKey(dataInsert.*) RETURNING errNo, errMsg, ret.lineitem_orderid, ret.lineitem_linenum
    LET errMsg = IIF(errNo = ERROR_SUCCESS, C_TXT_INSERT_SUCCESS_MSG, C_TXT_INSERT_FAIL_MSG), errMsg

    {<POINT Name="fct.LineItems_insertRow.user">} {</POINT>}
    RETURN errNo, errMsg, ret.*
END FUNCTION
{</BLOCK>} --fct.LineItems_insertRow

{<BLOCK Name="fct.Accounts_updateRow">}
#+ Update a row in the database
#+
#+ @param p_rec_br Business record values to update
#+ @param p_dataT0 - a row data LIKE account.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_Accounts_updateRow(p_rec_br, p_dataT0)
    DEFINE p_rec_br Accounts_br_type
    DEFINE p_dataT0 RECORD LIKE account.*
    DEFINE l_dataT1 RECORD LIKE account.*
    DEFINE l_rec_br_uk Accounts_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Accounts_updateRow.define">} {</POINT>}
    --Init local data with values from the DB array
    LET l_dataT1.* = p_dataT0.*
    --Set local data with form field values
    LET l_dataT1.userid = p_rec_br.account_userid
    LET l_dataT1.firstname = p_rec_br.account_firstname
    LET l_dataT1.lastname = p_rec_br.account_lastname
    LET l_dataT1.phone = p_rec_br.account_phone
    LET l_dataT1.email = p_rec_br.account_email
    --Set local Business Record Key data
    LET l_rec_br_uk.account_userid = p_dataT0.userid
    {<POINT Name="fct.Accounts_updateRow.init">} {</POINT>}

    --Call the database update row
    CALL officestore_dbxdata.officestore_dbxdata_account_pk_account_updateRowByKey(p_dataT0.*, l_dataT1.*) RETURNING errNo, errMsg
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_UPDATE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_UPDATE_FAIL_MSG, errMsg
    END CASE

    {<POINT Name="fct.Accounts_updateRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.Accounts_updateRow
{<BLOCK Name="fct.Orders_updateRow">}
#+ Update a row in the database
#+
#+ @param p_rec_br Business record values to update
#+ @param p_dataT0 - a row data LIKE orders.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_Orders_updateRow(p_rec_br, p_dataT0)
    DEFINE p_rec_br Orders_br_type
    DEFINE p_dataT0 RECORD LIKE orders.*
    DEFINE l_dataT1 RECORD LIKE orders.*
    DEFINE l_rec_br_uk Orders_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Orders_updateRow.define">} {</POINT>}
    --Init local data with values from the DB array
    LET l_dataT1.* = p_dataT0.*
    --Set local data with form field values
    LET l_dataT1.orderid = p_rec_br.orders_orderid
    LET l_dataT1.userid = p_rec_br.orders_userid
    LET l_dataT1.orderdate = p_rec_br.orders_orderdate
    LET l_dataT1.shipcountry = p_rec_br.orders_shipcountry
    LET l_dataT1.billcountry = p_rec_br.orders_billcountry
    LET l_dataT1.totalprice = p_rec_br.orders_totalprice
    --Set local Business Record Key data
    LET l_rec_br_uk.orders_orderid = p_dataT0.orderid
    {<POINT Name="fct.Orders_updateRow.init">} {</POINT>}

    --Call the database update row
    CALL officestore_dbxdata.officestore_dbxdata_orders_pk_orders_updateRowByKey(p_dataT0.*, l_dataT1.*) RETURNING errNo, errMsg
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_UPDATE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_UPDATE_FAIL_MSG, errMsg
    END CASE

    {<POINT Name="fct.Orders_updateRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.Orders_updateRow
{<BLOCK Name="fct.LineItems_updateRow">}
#+ Update a row in the database
#+
#+ @param p_rec_br Business record values to update
#+ @param p_dataT0 - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_LineItems_updateRow(p_rec_br, p_dataT0)
    DEFINE p_rec_br LineItems_br_type
    DEFINE p_dataT0 RECORD LIKE lineitem.*
    DEFINE l_dataT1 RECORD LIKE lineitem.*
    DEFINE l_rec_br_uk LineItems_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.LineItems_updateRow.define">} {</POINT>}
    --Init local data with values from the DB array
    LET l_dataT1.* = p_dataT0.*
    --Set local data with form field values
    LET l_dataT1.orderid = p_rec_br.lineitem_orderid
    LET l_dataT1.linenum = p_rec_br.lineitem_linenum
    LET l_dataT1.itemid = p_rec_br.lineitem_itemid
    LET l_dataT1.quantity = p_rec_br.lineitem_quantity
    LET l_dataT1.unitprice = p_rec_br.lineitem_unitprice
    --Set local Business Record Key data
    LET l_rec_br_uk.lineitem_orderid = p_dataT0.orderid
    LET l_rec_br_uk.lineitem_linenum = p_dataT0.linenum
    {<POINT Name="fct.LineItems_updateRow.init">} {</POINT>}

    --Call the database update row
    CALL officestore_dbxdata.officestore_dbxdata_lineitem_pk_lineitem_updateRowByKey(p_dataT0.*, l_dataT1.*) RETURNING errNo, errMsg
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_UPDATE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_UPDATE_FAIL_MSG, errMsg
    END CASE

    {<POINT Name="fct.LineItems_updateRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.LineItems_updateRow

{<BLOCK Name="fct.Accounts_deleteRow">}
#+ Delete a row in the database
#+
#+ @param p_rec_br_uk The Business Record(BR) Unique Keys (UK) in which the keys must be deleted
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_Accounts_deleteRow(p_rec_br_uk)
    DEFINE p_rec_br_uk Accounts_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Accounts_deleteRow.define">} {</POINT>}
    {<POINT Name="fct.Accounts_deleteRow.init">} {</POINT>}

    CALL officestore_dbxdata.officestore_dbxdata_account_pk_account_deleteRowByKey(p_rec_br_uk.account_userid) RETURNING errNo
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_DELETE_SUCCESS_MSG
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET errMsg = C_TXT_DELETE_FAIL_ROW_USED_MSG
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG
    END CASE

    {<POINT Name="fct.Accounts_deleteRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.Accounts_deleteRow
{<BLOCK Name="fct.Orders_deleteRow">}
#+ Delete a row in the database
#+
#+ @param p_rec_br_uk The Business Record(BR) Unique Keys (UK) in which the keys must be deleted
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_Orders_deleteRow(p_rec_br_uk)
    DEFINE p_rec_br_uk Orders_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Orders_deleteRow.define">} {</POINT>}
    {<POINT Name="fct.Orders_deleteRow.init">} {</POINT>}

    CALL officestore_dbxdata.officestore_dbxdata_orders_pk_orders_deleteRowByKey(p_rec_br_uk.orders_orderid) RETURNING errNo
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_DELETE_SUCCESS_MSG
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET errMsg = C_TXT_DELETE_FAIL_ROW_USED_MSG
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG
    END CASE

    {<POINT Name="fct.Orders_deleteRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.Orders_deleteRow
{<BLOCK Name="fct.LineItems_deleteRow">}
#+ Delete a row in the database
#+
#+ @param p_rec_br_uk The Business Record(BR) Unique Keys (UK) in which the keys must be deleted
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION Customers_uidata_LineItems_deleteRow(p_rec_br_uk)
    DEFINE p_rec_br_uk LineItems_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.LineItems_deleteRow.define">} {</POINT>}
    {<POINT Name="fct.LineItems_deleteRow.init">} {</POINT>}

    CALL officestore_dbxdata.officestore_dbxdata_lineitem_pk_lineitem_deleteRowByKey(p_rec_br_uk.lineitem_orderid, p_rec_br_uk.lineitem_linenum) RETURNING errNo
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_DELETE_SUCCESS_MSG
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET errMsg = C_TXT_DELETE_FAIL_ROW_USED_MSG
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG
    END CASE

    {<POINT Name="fct.LineItems_deleteRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.LineItems_deleteRow

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
