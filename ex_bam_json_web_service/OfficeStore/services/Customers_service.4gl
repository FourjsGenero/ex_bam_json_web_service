{<CODEFILE Path="Customers.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ JSON Web service

--------------------------------------------------------------------------------
--This code is generated with the template dbapp4.1
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
--Import Genero Web Service COM library
IMPORT com
IMPORT util
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql
IMPORT FGL libdbappWSCore
IMPORT FGL libdbappWS

IMPORT FGL officestore_dbxdata
IMPORT FGL Customers_uidata
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA officestore

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables

PUBLIC TYPE Accounts_ws_br_type
    RECORD
        account_userid LIKE account.userid,
        account_firstname LIKE account.firstname,
        account_lastname LIKE account.lastname,
        country_codedesc LIKE country.codedesc,
        account_phone LIKE account.phone,
        account_email LIKE account.email,
        category_catpic LIKE category.catpic
    END RECORD

PUBLIC TYPE Orders_ws_br_type
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

PUBLIC TYPE LineItems_ws_br_type
    RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum,
        lineitem_itemid LIKE lineitem.itemid,
        product_prodname LIKE product.prodname,
        lineitem_quantity LIKE lineitem.quantity,
        lineitem_unitprice LIKE lineitem.unitprice
    END RECORD

PUBLIC TYPE Accounts_ws_br_uk_type
    RECORD
        account_userid LIKE account.userid
    END RECORD

PUBLIC TYPE Orders_ws_br_uk_type
    RECORD
        orders_orderid LIKE orders.orderid
    END RECORD

PUBLIC TYPE LineItems_ws_br_uk_type
    RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum
    END RECORD

PUBLIC TYPE Accounts_ws_br_data_type
    RECORD
        account_firstname LIKE account.firstname,
        account_lastname LIKE account.lastname,
        country_codedesc LIKE country.codedesc,
        account_phone LIKE account.phone,
        account_email LIKE account.email,
        category_catpic LIKE category.catpic
    END RECORD

PUBLIC TYPE Orders_ws_br_data_type
    RECORD
        orders_userid LIKE orders.userid,
        orders_orderdate LIKE orders.orderdate,
        orders_shipcountry LIKE orders.shipcountry,
        ship_country_codedesc LIKE country.codedesc,
        orders_billcountry LIKE orders.billcountry,
        bill_country_codedesc LIKE country.codedesc,
        orders_totalprice LIKE orders.totalprice
    END RECORD

PUBLIC TYPE LineItems_ws_br_data_type
    RECORD
        lineitem_itemid LIKE lineitem.itemid,
        product_prodname LIKE product.prodname,
        lineitem_quantity LIKE lineitem.quantity,
        lineitem_unitprice LIKE lineitem.unitprice
    END RECORD

PUBLIC TYPE ws_br_qbe_type
    RECORD
        account_userid STRING,
        account_firstname STRING,
        account_lastname STRING,
        country_codedesc STRING,
        account_phone STRING,
        account_email STRING,
        category_catpic STRING,
        orders_orderid STRING,
        orders_userid STRING,
        orders_orderdate STRING,
        orders_shipcountry STRING,
        ship_country_codedesc STRING,
        orders_billcountry STRING,
        bill_country_codedesc STRING,
        orders_totalprice STRING,
        lineitem_orderid STRING,
        lineitem_linenum STRING,
        lineitem_itemid STRING,
        product_prodname STRING,
        lineitem_quantity STRING,
        lineitem_unitprice STRING
    END RECORD

DEFINE m_createAll_IN DYNAMIC ARRAY OF RECORD
    AccountsData Accounts_ws_br_type,
    detail_Orders DYNAMIC ARRAY OF RECORD
        OrdersData Orders_ws_br_type,
        detail_LineItems DYNAMIC ARRAY OF RECORD
            LineItemsData LineItems_ws_br_type
        END RECORD
    END RECORD
END RECORD

DEFINE m_createAll_OUT RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF RECORD
        AccountsKeys Accounts_ws_br_uk_type,
        detail_Orders DYNAMIC ARRAY OF RECORD
            OrdersKeys Orders_ws_br_uk_type,
            detail_LineItems DYNAMIC ARRAY OF RECORD
                LineItemsKeys LineItems_ws_br_uk_type
            END RECORD
        END RECORD
    END RECORD
END RECORD

DEFINE m_Accounts_create_IN DYNAMIC ARRAY OF Accounts_ws_br_type

DEFINE m_Accounts_create_OUT RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF Accounts_ws_br_uk_type
END RECORD

DEFINE m_Orders_create_IN DYNAMIC ARRAY OF Orders_ws_br_type

DEFINE m_Orders_create_OUT RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF Orders_ws_br_uk_type
END RECORD

DEFINE m_LineItems_create_IN DYNAMIC ARRAY OF LineItems_ws_br_type

DEFINE m_LineItems_create_OUT RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF LineItems_ws_br_uk_type
END RECORD

DEFINE m_readAll_IN ws_br_qbe_type

DEFINE m_readAll_OUT RECORD
    errNo INTEGER,
    resultset DYNAMIC ARRAY OF RECORD
        AccountsData Accounts_ws_br_type,
        detail_Orders DYNAMIC ARRAY OF RECORD
            OrdersData Orders_ws_br_type,
            detail_LineItems DYNAMIC ARRAY OF RECORD
                LineItemsData LineItems_ws_br_type
            END RECORD
        END RECORD
    END RECORD
END RECORD

DEFINE m_Accounts_read_IN Accounts_ws_br_uk_type

DEFINE m_Accounts_read_OUT RECORD
    errNo INTEGER,
    resultset Accounts_ws_br_type
END RECORD

DEFINE m_Orders_read_IN Orders_ws_br_uk_type

DEFINE m_Orders_read_OUT RECORD
    errNo INTEGER,
    resultset Orders_ws_br_type
END RECORD

DEFINE m_LineItems_read_IN LineItems_ws_br_uk_type

DEFINE m_LineItems_read_OUT RECORD
    errNo INTEGER,
    resultset LineItems_ws_br_type
END RECORD

DEFINE m_Accounts_update_IN DYNAMIC ARRAY OF RECORD
    keys Accounts_ws_br_uk_type,
    newData Accounts_ws_br_type
END RECORD

DEFINE m_Accounts_update_OUT RECORD
    errNo INTEGER
END RECORD

DEFINE m_Orders_update_IN DYNAMIC ARRAY OF RECORD
    keys Orders_ws_br_uk_type,
    newData Orders_ws_br_type
END RECORD

DEFINE m_Orders_update_OUT RECORD
    errNo INTEGER
END RECORD

DEFINE m_LineItems_update_IN DYNAMIC ARRAY OF RECORD
    keys LineItems_ws_br_uk_type,
    newData LineItems_ws_br_type
END RECORD

DEFINE m_LineItems_update_OUT RECORD
    errNo INTEGER
END RECORD

DEFINE m_Accounts_delete_IN DYNAMIC ARRAY OF Accounts_ws_br_uk_type

DEFINE m_Accounts_delete_OUT RECORD
    errNo INTEGER
END RECORD

DEFINE m_Orders_delete_IN DYNAMIC ARRAY OF Orders_ws_br_uk_type

DEFINE m_Orders_delete_OUT RECORD
    errNo INTEGER
END RECORD

DEFINE m_LineItems_delete_IN DYNAMIC ARRAY OF LineItems_ws_br_uk_type

DEFINE m_LineItems_delete_OUT RECORD
    errNo INTEGER
END RECORD

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="fct.process">}
#+ Processes the 'Customers' service.
#+
#+ @param dbappHttpRequest an HTTP REST service request
#+
#+ @returnType libdbappWS.restHttpResponse
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return 'Customers' data serialized in JSON
#+
PUBLIC FUNCTION Customers_service_process(dbappHttpRequest)
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest
    DEFINE dbappHttpResponse libdbappWS.restHttpResponse

    DEFINE targetResource STRING
    {<POINT Name="fct.process.define">} {</POINT>}

    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*

    # If there is no hierarchical structure, then the target resource is the
    # full data source, i.e the set of records, else the target resource is the
    # last item of the hierarchical structure.
    IF (dbappHttpRequest.resources.names.getLength() > 0) THEN
        LET targetResource = dbappHttpRequest.resources.names[dbappHttpRequest.resources.names.getLength()]
    ELSE
        LET targetResource = "Customers"
    END IF
    {<POINT Name="fct.process.init">} {</POINT>}

    CASE targetResource
        {<POINT Name="fct.process.AdditionalResources">} {</POINT>}
        WHEN "Customers"
            CALL Customers_service_processAll(dbappHttpRequest.*) RETURNING dbappHttpResponse.*
        WHEN "Accounts"
            CALL Customers_service_Accounts_process(dbappHttpRequest.*) RETURNING dbappHttpResponse.*
        WHEN "Accounts/Orders"
            CALL Customers_service_Orders_process(dbappHttpRequest.*) RETURNING dbappHttpResponse.*
        WHEN "Accounts/Orders/LineItems"
            CALL Customers_service_LineItems_process(dbappHttpRequest.*) RETURNING dbappHttpResponse.*
        OTHERWISE
            LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_404_code
    END CASE

    RETURN dbappHttpResponse.*
END FUNCTION
{</BLOCK>} --fct.process

{<BLOCK Name="fct.processAll">}
#+ Processes the 'Customers' resource for the createAll and readAll operations.
#+
#+ @param dbappHttpRequest an HTTP REST service request
#+
#+ @returnType libdbappWS.restHttpResponse
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return 'Customers' data serialized in JSON
#+
PRIVATE FUNCTION Customers_service_processAll(dbappHttpRequest)
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest
    DEFINE dbappHttpResponse libdbappWS.restHttpResponse
    {<POINT Name="fct.processAll.define">} {</POINT>}

    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*
    {<POINT Name="fct.processAll.init">} {</POINT>}

    CASE libdbappWS.getRestHttpCRUDOperation(dbappHttpRequest.method, dbappHttpRequest.CRUDOperation)
        {<POINT Name="fct.processAll.AdditionalMethods">} {</POINT>}

        WHEN "CREATECollection"
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_createAll_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_createAll_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_createAll()
            CASE m_createAll_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_createAll_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_FAILURE
                    LET dbappHttpResponse.data = util.JSON.stringify(m_createAll_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_409_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "READCollection"
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_readAll_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_readAll_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_readAll()
            IF (m_readAll_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_readAll_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF

        OTHERWISE
            LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_405_code
    END CASE

    RETURN dbappHttpResponse.*
END FUNCTION
{</BLOCK>} --fct.processAll

{<BLOCK Name="fct.Accounts_process">}
#+ Processes the 'Accounts' resource.
#+
#+ @param dbappHttpRequest an HTTP REST service request
#+
#+ @returnType libdbappWS.restHttpResponse
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return 'Accounts' data serialized in JSON
#+
PRIVATE FUNCTION Customers_service_Accounts_process(dbappHttpRequest)
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest
    DEFINE dbappHttpResponse libdbappWS.restHttpResponse

    DEFINE itemNewData Accounts_ws_br_data_type
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Accounts_process.define">} {</POINT>}

    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Accounts_process.init">} {</POINT>}

    CASE libdbappWS.getRestHttpCRUDOperation(dbappHttpRequest.method, dbappHttpRequest.CRUDOperation)
        {<POINT Name="fct.Accounts_process.AdditionalMethods">} {</POINT>}
        WHEN "CREATECollection"
            CALL m_Accounts_create_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Accounts_create_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_create_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Accounts_create()
            CASE m_Accounts_create_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_FAILURE
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_409_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "READItem"
            INITIALIZE m_Accounts_read_IN TO NULL
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Accounts_read_IN.account_userid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Accounts_read()
            CASE m_Accounts_read_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_NOTFOUND
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_404_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "UPDATEItem"
            CALL m_Accounts_update_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Accounts_update_IN[1].keys.account_userid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, itemNewData)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            LET m_Accounts_update_IN[1].newData.account_userid = m_Accounts_update_IN[1].keys.account_userid
            LET m_Accounts_update_IN[1].newData.account_firstname = itemNewData.account_firstname
            LET m_Accounts_update_IN[1].newData.account_lastname = itemNewData.account_lastname
            LET m_Accounts_update_IN[1].newData.country_codedesc = itemNewData.country_codedesc
            LET m_Accounts_update_IN[1].newData.account_phone = itemNewData.account_phone
            LET m_Accounts_update_IN[1].newData.account_email = itemNewData.account_email
            LET m_Accounts_update_IN[1].newData.category_catpic = itemNewData.category_catpic
            CALL Customers_service_Accounts_update()
            IF (m_Accounts_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "UPDATECollection"
            CALL m_Accounts_update_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Accounts_update_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Accounts_update()
            IF (m_Accounts_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETEItem"
            CALL m_Accounts_delete_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Accounts_delete_IN[1].account_userid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Accounts_delete()
            IF (m_Accounts_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETECollection"
            CALL m_Accounts_delete_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Accounts_delete_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Accounts_delete()
            IF (m_Accounts_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Accounts_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        OTHERWISE
            LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_405_code
    END CASE

    RETURN dbappHttpResponse.*
END FUNCTION
{</BLOCK>} --fct.Accounts_process

{<BLOCK Name="fct.Orders_process">}
#+ Processes the 'Orders' resource.
#+
#+ @param dbappHttpRequest an HTTP REST service request
#+
#+ @returnType libdbappWS.restHttpResponse
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return 'Orders' data serialized in JSON
#+
PRIVATE FUNCTION Customers_service_Orders_process(dbappHttpRequest)
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest
    DEFINE dbappHttpResponse libdbappWS.restHttpResponse

    DEFINE itemNewData Orders_ws_br_data_type
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Orders_process.define">} {</POINT>}

    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Orders_process.init">} {</POINT>}

    CASE libdbappWS.getRestHttpCRUDOperation(dbappHttpRequest.method, dbappHttpRequest.CRUDOperation)
        {<POINT Name="fct.Orders_process.AdditionalMethods">} {</POINT>}
        WHEN "CREATECollection"
            CALL m_Orders_create_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Orders_create_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_create_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Orders_create()
            CASE m_Orders_create_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_FAILURE
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_409_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "READItem"
            INITIALIZE m_Orders_read_IN TO NULL
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Orders_read_IN.orders_orderid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Orders_read()
            CASE m_Orders_read_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_NOTFOUND
                    LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_404_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "UPDATEItem"
            CALL m_Orders_update_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Orders_update_IN[1].keys.orders_orderid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, itemNewData)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            LET m_Orders_update_IN[1].newData.orders_orderid = m_Orders_update_IN[1].keys.orders_orderid
            LET m_Orders_update_IN[1].newData.orders_userid = itemNewData.orders_userid
            LET m_Orders_update_IN[1].newData.orders_orderdate = itemNewData.orders_orderdate
            LET m_Orders_update_IN[1].newData.orders_shipcountry = itemNewData.orders_shipcountry
            LET m_Orders_update_IN[1].newData.ship_country_codedesc = itemNewData.ship_country_codedesc
            LET m_Orders_update_IN[1].newData.orders_billcountry = itemNewData.orders_billcountry
            LET m_Orders_update_IN[1].newData.bill_country_codedesc = itemNewData.bill_country_codedesc
            LET m_Orders_update_IN[1].newData.orders_totalprice = itemNewData.orders_totalprice
            CALL Customers_service_Orders_update()
            IF (m_Orders_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "UPDATECollection"
            CALL m_Orders_update_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Orders_update_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Orders_update()
            IF (m_Orders_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETEItem"
            CALL m_Orders_delete_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_Orders_delete_IN[1].orders_orderid = keyList[1]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Orders_delete()
            IF (m_Orders_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETECollection"
            CALL m_Orders_delete_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_Orders_delete_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_Orders_delete()
            IF (m_Orders_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_Orders_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        OTHERWISE
            LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_405_code
    END CASE

    RETURN dbappHttpResponse.*
END FUNCTION
{</BLOCK>} --fct.Orders_process

{<BLOCK Name="fct.LineItems_process">}
#+ Processes the 'LineItems' resource.
#+
#+ @param dbappHttpRequest an HTTP REST service request
#+
#+ @returnType libdbappWS.restHttpResponse
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return 'LineItems' data serialized in JSON
#+
PRIVATE FUNCTION Customers_service_LineItems_process(dbappHttpRequest)
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest
    DEFINE dbappHttpResponse libdbappWS.restHttpResponse

    DEFINE itemNewData LineItems_ws_br_data_type
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.LineItems_process.define">} {</POINT>}

    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.LineItems_process.init">} {</POINT>}

    CASE libdbappWS.getRestHttpCRUDOperation(dbappHttpRequest.method, dbappHttpRequest.CRUDOperation)
        {<POINT Name="fct.LineItems_process.AdditionalMethods">} {</POINT>}
        WHEN "CREATECollection"
            CALL m_LineItems_create_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_LineItems_create_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_create_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_LineItems_create()
            CASE m_LineItems_create_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_FAILURE
                    LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_create_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_409_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "READItem"
            INITIALIZE m_LineItems_read_IN TO NULL
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_LineItems_read_IN.lineitem_orderid = keyList[1]
                LET m_LineItems_read_IN.lineitem_linenum = keyList[2]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_LineItems_read()
            CASE m_LineItems_read_OUT.errNo
                WHEN ERROR_SUCCESS
                    LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
                WHEN ERROR_NOTFOUND
                    LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_read_OUT)
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_404_code
                OTHERWISE
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END CASE
        WHEN "UPDATEItem"
            CALL m_LineItems_update_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_LineItems_update_IN[1].keys.lineitem_orderid = keyList[1]
                LET m_LineItems_update_IN[1].keys.lineitem_linenum = keyList[2]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, itemNewData)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            LET m_LineItems_update_IN[1].newData.lineitem_orderid = m_LineItems_update_IN[1].keys.lineitem_orderid
            LET m_LineItems_update_IN[1].newData.lineitem_linenum = m_LineItems_update_IN[1].keys.lineitem_linenum
            LET m_LineItems_update_IN[1].newData.lineitem_itemid = itemNewData.lineitem_itemid
            LET m_LineItems_update_IN[1].newData.product_prodname = itemNewData.product_prodname
            LET m_LineItems_update_IN[1].newData.lineitem_quantity = itemNewData.lineitem_quantity
            LET m_LineItems_update_IN[1].newData.lineitem_unitprice = itemNewData.lineitem_unitprice
            CALL Customers_service_LineItems_update()
            IF (m_LineItems_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "UPDATECollection"
            CALL m_LineItems_update_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_LineItems_update_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_LineItems_update()
            IF (m_LineItems_update_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_update_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETEItem"
            CALL m_LineItems_delete_IN.clear()
            TRY
                CALL libdbappWSCore.decodeParams(dbappHttpRequest.resources.ids[1]) RETURNING keyList
                LET m_LineItems_delete_IN[1].lineitem_orderid = keyList[1]
                LET m_LineItems_delete_IN[1].lineitem_linenum = keyList[2]
            CATCH
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_LineItems_delete()
            IF (m_LineItems_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        WHEN "DELETECollection"
            CALL m_LineItems_delete_IN.clear()
            TRY
                CALL util.JSON.parse(dbappHttpRequest.parameters, m_LineItems_delete_IN)
            CATCH
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_400_code
                EXIT CASE
            END TRY
            CALL Customers_service_LineItems_delete()
            IF (m_LineItems_delete_OUT.errNo == ERROR_SUCCESS) THEN
                LET dbappHttpResponse.data = util.JSON.stringify(m_LineItems_delete_OUT)
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_200_code
            ELSE
                LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_500_code
            END IF
        OTHERWISE
            LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_405_code
    END CASE

    RETURN dbappHttpResponse.*
END FUNCTION
{</BLOCK>} --fct.LineItems_process

{<BLOCK Name="fct.createAll">}
#+ Insert documents in the database
#+
PUBLIC FUNCTION Customers_service_createAll()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    DEFINE br Accounts_br_type
    DEFINE dataInsert RECORD LIKE account.*
    DEFINE i_Orders INTEGER
    DEFINE size_Orders INTEGER
    DEFINE br_Orders Orders_br_type
    DEFINE dataInsert_Orders RECORD LIKE orders.*
    DEFINE i_LineItems INTEGER
    DEFINE size_LineItems INTEGER
    DEFINE br_LineItems LineItems_br_type
    DEFINE dataInsert_LineItems RECORD LIKE lineitem.*
    {<POINT Name="fct.createAll.define">} {</POINT>}
    {<POINT Name="fct.createAll.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_createAll_IN.getLength()
        FOR i = 1 TO size
            --Init local data with default values from the DB schema
            CALL officestore_dbxdata.officestore_dbxdata_account_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
            --Set local data with form field values
            INITIALIZE br.* TO NULL
            LET br.account_userid = m_createAll_IN[i].AccountsData.account_userid
            LET br.account_firstname = m_createAll_IN[i].AccountsData.account_firstname
            LET br.account_lastname = m_createAll_IN[i].AccountsData.account_lastname
            LET br.country_codedesc = m_createAll_IN[i].AccountsData.country_codedesc
            LET br.account_phone = m_createAll_IN[i].AccountsData.account_phone
            LET br.account_email = m_createAll_IN[i].AccountsData.account_email
            LET br.category_catpic = m_createAll_IN[i].AccountsData.category_catpic
            {<POINT Name="fct.Accounts_createAll.beforeCreateAll">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_Accounts_insertRow(br.*) RETURNING errNo, errMsg, m_createAll_OUT.keys[i].AccountsKeys.*
            {<POINT Name="fct.Accounts_createAll.afterCreateAll">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
            LET size_Orders = m_createAll_IN[i].detail_Orders.getLength()
            FOR i_Orders = 1 TO size_Orders
                --Init local data with default values from the DB schema
                CALL officestore_dbxdata.officestore_dbxdata_orders_setDefaultValuesFromDBSchema() RETURNING dataInsert_Orders.*
                --Set local data with form field values
                INITIALIZE br_Orders.* TO NULL
                LET br_Orders.orders_orderid = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.orders_orderid
                LET br_Orders.orders_userid = m_createAll_OUT.keys[i].AccountsKeys.account_userid
                LET br_Orders.orders_orderdate = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.orders_orderdate
                LET br_Orders.orders_shipcountry = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.orders_shipcountry
                LET br_Orders.ship_country_codedesc = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.ship_country_codedesc
                LET br_Orders.orders_billcountry = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.orders_billcountry
                LET br_Orders.bill_country_codedesc = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.bill_country_codedesc
                LET br_Orders.orders_totalprice = m_createAll_IN[i].detail_Orders[i_Orders].OrdersData.orders_totalprice
                {<POINT Name="fct.Orders_createAll.beforeCreateAll">} {</POINT>}
                CALL Customers_uidata.Customers_uidata_Orders_insertRow(br_Orders.*) RETURNING errNo, errMsg, m_createAll_OUT.keys[i].detail_Orders[i_Orders].OrdersKeys.*
                {<POINT Name="fct.Orders_createAll.afterCreateAll">} {</POINT>}
                IF errNo != ERROR_SUCCESS THEN
                    EXIT FOR
                END IF
                LET size_LineItems = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems.getLength()
                FOR i_LineItems = 1 TO size_LineItems
                    --Init local data with default values from the DB schema
                    CALL officestore_dbxdata.officestore_dbxdata_lineitem_setDefaultValuesFromDBSchema() RETURNING dataInsert_LineItems.*
                    --Set local data with form field values
                    INITIALIZE br_LineItems.* TO NULL
                    LET br_LineItems.lineitem_orderid = m_createAll_OUT.keys[i].detail_Orders[i_Orders].OrdersKeys.orders_orderid
                    LET br_LineItems.lineitem_linenum = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.lineitem_linenum
                    LET br_LineItems.lineitem_itemid = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.lineitem_itemid
                    LET br_LineItems.product_prodname = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.product_prodname
                    LET br_LineItems.lineitem_quantity = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.lineitem_quantity
                    LET br_LineItems.lineitem_unitprice = m_createAll_IN[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.lineitem_unitprice
                    {<POINT Name="fct.LineItems_createAll.beforeCreateAll">} {</POINT>}
                    CALL Customers_uidata.Customers_uidata_LineItems_insertRow(br_LineItems.*) RETURNING errNo, errMsg, m_createAll_OUT.keys[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsKeys.*
                    {<POINT Name="fct.LineItems_createAll.afterCreateAll">} {</POINT>}
                    IF errNo != ERROR_SUCCESS THEN
                        EXIT FOR
                    END IF
                END FOR
                IF errNo != ERROR_SUCCESS THEN
                    CALL m_createAll_OUT.keys[i].detail_Orders[i_Orders].detail_LineItems.clear()
                    EXIT FOR
                END IF
            END FOR
            IF errNo != ERROR_SUCCESS THEN
                CALL m_createAll_OUT.keys[i].detail_Orders.clear()
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL m_createAll_OUT.keys.clear()
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_createAll_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.createAll

{<BLOCK Name="fct.Accounts_create">}
#+ Insert rows in the database
#+
PUBLIC FUNCTION Customers_service_Accounts_create()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE br Accounts_br_type
    DEFINE dataInsert RECORD LIKE account.*
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Accounts_create.define">} {</POINT>}
    {<POINT Name="fct.Accounts_create.init">} {</POINT>}
    CALL m_Accounts_create_OUT.keys.clear()
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Accounts_create_IN.getLength()
        FOR i = 1 TO size
            --Init local data with default values from the DB schema
            CALL officestore_dbxdata.officestore_dbxdata_account_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
            --Set local data with form field values
            INITIALIZE br.* TO NULL
            LET br.account_userid = m_Accounts_create_IN[i].account_userid
            LET br.account_firstname = m_Accounts_create_IN[i].account_firstname
            LET br.account_lastname = m_Accounts_create_IN[i].account_lastname
            LET br.country_codedesc = m_Accounts_create_IN[i].country_codedesc
            LET br.account_phone = m_Accounts_create_IN[i].account_phone
            LET br.account_email = m_Accounts_create_IN[i].account_email
            LET br.category_catpic = m_Accounts_create_IN[i].category_catpic
            {<POINT Name="fct.Accounts_create.beforeCreate">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_Accounts_insertRow(br.*) RETURNING errNo, errMsg, m_Accounts_create_OUT.keys[i].*
            {<POINT Name="fct.Accounts_create.afterCreate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL m_Accounts_create_OUT.keys.clear()
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Accounts_create_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Accounts_create

{<BLOCK Name="fct.Orders_create">}
#+ Insert rows in the database
#+
PUBLIC FUNCTION Customers_service_Orders_create()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE br Orders_br_type
    DEFINE dataInsert RECORD LIKE orders.*
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Orders_create.define">} {</POINT>}
    {<POINT Name="fct.Orders_create.init">} {</POINT>}
    CALL m_Orders_create_OUT.keys.clear()
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Orders_create_IN.getLength()
        FOR i = 1 TO size
            --Init local data with default values from the DB schema
            CALL officestore_dbxdata.officestore_dbxdata_orders_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
            --Set local data with form field values
            INITIALIZE br.* TO NULL
            LET br.orders_orderid = m_Orders_create_IN[i].orders_orderid
            LET br.orders_userid = m_Orders_create_IN[i].orders_userid
            LET br.orders_orderdate = m_Orders_create_IN[i].orders_orderdate
            LET br.orders_shipcountry = m_Orders_create_IN[i].orders_shipcountry
            LET br.ship_country_codedesc = m_Orders_create_IN[i].ship_country_codedesc
            LET br.orders_billcountry = m_Orders_create_IN[i].orders_billcountry
            LET br.bill_country_codedesc = m_Orders_create_IN[i].bill_country_codedesc
            LET br.orders_totalprice = m_Orders_create_IN[i].orders_totalprice
            {<POINT Name="fct.Orders_create.beforeCreate">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_Orders_insertRow(br.*) RETURNING errNo, errMsg, m_Orders_create_OUT.keys[i].*
            {<POINT Name="fct.Orders_create.afterCreate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL m_Orders_create_OUT.keys.clear()
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Orders_create_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Orders_create

{<BLOCK Name="fct.LineItems_create">}
#+ Insert rows in the database
#+
PUBLIC FUNCTION Customers_service_LineItems_create()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE br LineItems_br_type
    DEFINE dataInsert RECORD LIKE lineitem.*
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.LineItems_create.define">} {</POINT>}
    {<POINT Name="fct.LineItems_create.init">} {</POINT>}
    CALL m_LineItems_create_OUT.keys.clear()
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_LineItems_create_IN.getLength()
        FOR i = 1 TO size
            --Init local data with default values from the DB schema
            CALL officestore_dbxdata.officestore_dbxdata_lineitem_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
            --Set local data with form field values
            INITIALIZE br.* TO NULL
            LET br.lineitem_orderid = m_LineItems_create_IN[i].lineitem_orderid
            LET br.lineitem_linenum = m_LineItems_create_IN[i].lineitem_linenum
            LET br.lineitem_itemid = m_LineItems_create_IN[i].lineitem_itemid
            LET br.product_prodname = m_LineItems_create_IN[i].product_prodname
            LET br.lineitem_quantity = m_LineItems_create_IN[i].lineitem_quantity
            LET br.lineitem_unitprice = m_LineItems_create_IN[i].lineitem_unitprice
            {<POINT Name="fct.LineItems_create.beforeCreate">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_LineItems_insertRow(br.*) RETURNING errNo, errMsg, m_LineItems_create_OUT.keys[i].*
            {<POINT Name="fct.LineItems_create.afterCreate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL m_LineItems_create_OUT.keys.clear()
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_LineItems_create_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.LineItems_create

{<BLOCK Name="fct.readAll">}
#+ Read documents
#+
PUBLIC FUNCTION Customers_service_readAll()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE sqlQuery STRING
    DEFINE sqlDistinct STRING
    DEFINE sqlFrom STRING
    DEFINE sqlWhere STRING
    DEFINE sqlWhereTmp STRING
    DEFINE br_Accounts Accounts_ws_br_type
    DEFINE i INTEGER
    DEFINE sqlFrom_Accounts STRING
    DEFINE sqlFrom_Orders STRING
    DEFINE sqlFrom_LineItems STRING
    DEFINE sqlQuery_Orders STRING
    DEFINE i_Orders INTEGER
    DEFINE br_Orders Orders_ws_br_type
    DEFINE sqlQuery_LineItems STRING
    DEFINE i_LineItems INTEGER
    DEFINE br_LineItems LineItems_ws_br_type
    {<POINT Name="fct.readAll.define">} {</POINT>}
    {<POINT Name="fct.readAll.init">} {</POINT>}

    CALL m_readAll_OUT.resultset.clear()
    --build where part for 'LineItems'
    INITIALIZE sqlWhereTmp TO NULL
    IF m_readAll_IN.lineitem_orderid IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('lineitem.orderid','INTEGER',m_readAll_IN.lineitem_orderid)
    END IF
    IF m_readAll_IN.lineitem_linenum IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('lineitem.linenum','INTEGER',m_readAll_IN.lineitem_linenum)
    END IF
    IF m_readAll_IN.lineitem_itemid IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('lineitem.itemid','CHAR(10)',m_readAll_IN.lineitem_itemid)
    END IF
    IF m_readAll_IN.product_prodname IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('product.prodname','CHAR(80)',m_readAll_IN.product_prodname)
    END IF
    IF m_readAll_IN.lineitem_quantity IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('lineitem.quantity','INTEGER',m_readAll_IN.lineitem_quantity)
    END IF
    IF m_readAll_IN.lineitem_unitprice IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('lineitem.unitprice','DECIMAL(10,2)',m_readAll_IN.lineitem_unitprice)
    END IF
    {<POINT Name="fct.LineItems_readAll.whereClause">} {</POINT>}
    IF sqlWhereTmp IS NOT NULL THEN
        LET sqlWhere = sqlWhere,sqlWhereTmp
        LET sqlFrom_LineItems = " INNER JOIN lineitem ON ( orders.orderid=lineitem.orderid )
            INNER JOIN item ON ( lineitem.itemid = item.itemid )
            INNER JOIN product ON ( item.productid = product.productid )"
        LET sqlDistinct = "DISTINCT"
        {<POINT Name="fct.LineItems_readAll.fromClause">} {</POINT>}
    END IF
    --build where part for 'Orders'
    INITIALIZE sqlWhereTmp TO NULL
    IF m_readAll_IN.orders_orderid IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.orderid','SERIAL',m_readAll_IN.orders_orderid)
    END IF
    IF m_readAll_IN.orders_userid IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.userid','CHAR(80)',m_readAll_IN.orders_userid)
    END IF
    IF m_readAll_IN.orders_orderdate IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.orderdate','DATE',m_readAll_IN.orders_orderdate)
    END IF
    IF m_readAll_IN.orders_shipcountry IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.shipcountry','CHAR(3)',m_readAll_IN.orders_shipcountry)
    END IF
    IF m_readAll_IN.ship_country_codedesc IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('ship_country.codedesc','CHAR(50)',m_readAll_IN.ship_country_codedesc)
    END IF
    IF m_readAll_IN.orders_billcountry IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.billcountry','CHAR(3)',m_readAll_IN.orders_billcountry)
    END IF
    IF m_readAll_IN.bill_country_codedesc IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('bill_country.codedesc','CHAR(50)',m_readAll_IN.bill_country_codedesc)
    END IF
    IF m_readAll_IN.orders_totalprice IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('orders.totalprice','DECIMAL(10,2)',m_readAll_IN.orders_totalprice)
    END IF
    {<POINT Name="fct.Orders_readAll.whereClause">} {</POINT>}
    IF sqlWhereTmp IS NOT NULL OR sqlFrom_LineItems IS NOT NULL THEN
        LET sqlWhere = sqlWhere,sqlWhereTmp
        LET sqlFrom_Orders = " INNER JOIN orders ON ( account.userid=orders.userid )
            INNER JOIN country bill_country ON ( orders.billcountry = bill_country.code )
            INNER JOIN country ship_country ON ( orders.shipcountry = ship_country.code )",sqlFrom_LineItems
        LET sqlDistinct = "DISTINCT"
        {<POINT Name="fct.Orders_readAll.fromClause">} {</POINT>}
    END IF
    --build where part for 'Accounts'
    INITIALIZE sqlWhereTmp TO NULL
    IF m_readAll_IN.account_userid IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('account.userid','CHAR(80)',m_readAll_IN.account_userid)
    END IF
    IF m_readAll_IN.account_firstname IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('account.firstname','CHAR(80)',m_readAll_IN.account_firstname)
    END IF
    IF m_readAll_IN.account_lastname IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('account.lastname','CHAR(80)',m_readAll_IN.account_lastname)
    END IF
    IF m_readAll_IN.country_codedesc IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('country.codedesc','CHAR(50)',m_readAll_IN.country_codedesc)
    END IF
    IF m_readAll_IN.account_phone IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('account.phone','CHAR(80)',m_readAll_IN.account_phone)
    END IF
    IF m_readAll_IN.account_email IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('account.email','CHAR(80)',m_readAll_IN.account_email)
    END IF
    IF m_readAll_IN.category_catpic IS NOT NULL THEN
        LET sqlWhereTmp = sqlWhereTmp,' AND ',libdbapp_fgl_construct('category.catpic','CHAR(255)',m_readAll_IN.category_catpic)
    END IF
    {<POINT Name="fct.Accounts_readAll.whereClause">} {</POINT>}
    IF sqlWhereTmp IS NOT NULL OR sqlFrom_Orders IS NOT NULL THEN
        LET sqlWhere = sqlWhere,sqlWhereTmp
        LET sqlFrom = sqlFrom,sqlFrom_Orders
        {<POINT Name="fct.Accounts_readAll.fromClause">} {</POINT>}
    END IF
    LET sqlQuery =
        ' SELECT ', sqlDistinct, ' account.userid,
                                account.firstname,
                                account.lastname,
                                country.codedesc,
                                account.phone,
                                account.email,
                                category.catpic'
     ,' FROM account
            INNER JOIN country ON ( account.country = country.code )
INNER JOIN category ON ( account.favcategory = category.catid )'
     , sqlFrom
     ,' WHERE 1=1'
     , sqlWhere

    LET sqlQuery_Orders =
        ' SELECT orders.orderid,
                    orders.userid,
                    orders.orderdate,
                    orders.shipcountry,
                    ship_country.codedesc,
                    orders.billcountry,
                    bill_country.codedesc,
                    orders.totalprice'
     ,' FROM orders
            INNER JOIN country bill_country ON ( orders.billcountry = bill_country.code )
    INNER JOIN country ship_country ON ( orders.shipcountry = ship_country.code )'
     ,' WHERE 1=1'
     ,' AND orders.userid=?'

    {<POINT Name="fct.Orders_readAll.query">} {</POINT>}

    LET sqlQuery_LineItems =
        ' SELECT lineitem.orderid,
                    lineitem.linenum,
                    lineitem.itemid,
                    product.prodname,
                    lineitem.quantity,
                    lineitem.unitprice'
     ,' FROM lineitem
            INNER JOIN item ON ( lineitem.itemid = item.itemid )
    INNER JOIN product ON ( item.productid = product.productid )'
     ,' WHERE 1=1'
     ,' AND lineitem.orderid=?'

    {<POINT Name="fct.LineItems_readAll.query">} {</POINT>}
    LET errNo = ERROR_SUCCESS
    {<POINT Name="fct.readAll.beforeReadAll">} {</POINT>}
    TRY
        DECLARE Customers_service_readAll CURSOR FROM sqlQuery
        DECLARE Customers_service_readAll_Orders CURSOR FROM sqlQuery_Orders
        DECLARE Customers_service_readAll_LineItems CURSOR FROM sqlQuery_LineItems
        LET i = 0
        FOREACH Customers_service_readAll
            INTO  br_Accounts.account_userid,
                        br_Accounts.account_firstname,
                        br_Accounts.account_lastname,
                        br_Accounts.country_codedesc,
                        br_Accounts.account_phone,
                        br_Accounts.account_email,
                        br_Accounts.category_catpic
            LET i = i + 1
            LET m_readAll_OUT.resultset[i].AccountsData.* = br_Accounts.*
            {<POINT Name="fct.readAll.result">} {</POINT>}
            LET i_Orders = 0
            FOREACH Customers_service_readAll_Orders
                USING m_readAll_OUT.resultset[i].AccountsData.account_userid
                INTO  br_Orders.orders_orderid,
                            br_Orders.orders_userid,
                            br_Orders.orders_orderdate,
                            br_Orders.orders_shipcountry,
                            br_Orders.ship_country_codedesc,
                            br_Orders.orders_billcountry,
                            br_Orders.bill_country_codedesc,
                            br_Orders.orders_totalprice
                LET i_Orders = i_Orders + 1
                LET m_readAll_OUT.resultset[i].detail_Orders[i_Orders].OrdersData.* = br_Orders.*
                {<POINT Name="fct.Orders_readAll.result">} {</POINT>}
                LET i_LineItems = 0
                FOREACH Customers_service_readAll_LineItems
                    USING m_readAll_OUT.resultset[i].detail_Orders[i_Orders].OrdersData.orders_orderid
                    INTO  br_LineItems.lineitem_orderid,
                                br_LineItems.lineitem_linenum,
                                br_LineItems.lineitem_itemid,
                                br_LineItems.product_prodname,
                                br_LineItems.lineitem_quantity,
                                br_LineItems.lineitem_unitprice
                    LET i_LineItems = i_LineItems + 1
                    LET m_readAll_OUT.resultset[i].detail_Orders[i_Orders].detail_LineItems[i_LineItems].LineItemsData.* = br_LineItems.*
                    {<POINT Name="fct.LineItems_readAll.result">} {</POINT>}
                END FOREACH
            END FOREACH
        END FOREACH
    CATCH
        INITIALIZE m_readAll_OUT.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.readAll.afterReadAll">} {</POINT>}
    LET m_readAll_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.readAll

{<BLOCK Name="fct.Accounts_read">}
#+ Read a row in the database from the given Business Record (BR) Unique Key (UK)
#+
PUBLIC FUNCTION Customers_service_Accounts_read()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Accounts_read.define">} {</POINT>}
    {<POINT Name="fct.Accounts_read.init">} {</POINT>}
    INITIALIZE m_Accounts_read_OUT.resultset.* TO NULL
    LET errNo = ERROR_SUCCESS
    {<POINT Name="fct.Accounts_read.beforeRead">} {</POINT>}
    TRY
        SELECT      account.userid,
                                account.firstname,
                                account.lastname,
                                country.codedesc,
                                account.phone,
                                account.email,
                                category.catpic
        INTO        m_Accounts_read_OUT.resultset.account_userid,
                                m_Accounts_read_OUT.resultset.account_firstname,
                                m_Accounts_read_OUT.resultset.account_lastname,
                                m_Accounts_read_OUT.resultset.country_codedesc,
                                m_Accounts_read_OUT.resultset.account_phone,
                                m_Accounts_read_OUT.resultset.account_email,
                                m_Accounts_read_OUT.resultset.category_catpic
        FROM        account
            INNER JOIN country ON ( account.country = country.code )
INNER JOIN category ON ( account.favcategory = category.catid )
        WHERE       1=1
        AND        account.userid = m_Accounts_read_IN.account_userid
    IF SQLCA.SQLCODE == NOTFOUND THEN
        LET errNo = ERROR_NOTFOUND
    END IF
    CATCH
        INITIALIZE m_Accounts_read_OUT.resultset.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.Accounts_read.afterRead">} {</POINT>}
    LET m_Accounts_read_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Accounts_read

{<BLOCK Name="fct.Orders_read">}
#+ Read a row in the database from the given Business Record (BR) Unique Key (UK)
#+
PUBLIC FUNCTION Customers_service_Orders_read()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.Orders_read.define">} {</POINT>}
    {<POINT Name="fct.Orders_read.init">} {</POINT>}
    INITIALIZE m_Orders_read_OUT.resultset.* TO NULL
    LET errNo = ERROR_SUCCESS
    {<POINT Name="fct.Orders_read.beforeRead">} {</POINT>}
    TRY
        SELECT      orders.orderid,
                                orders.userid,
                                orders.orderdate,
                                orders.shipcountry,
                                ship_country.codedesc,
                                orders.billcountry,
                                bill_country.codedesc,
                                orders.totalprice
        INTO        m_Orders_read_OUT.resultset.orders_orderid,
                                m_Orders_read_OUT.resultset.orders_userid,
                                m_Orders_read_OUT.resultset.orders_orderdate,
                                m_Orders_read_OUT.resultset.orders_shipcountry,
                                m_Orders_read_OUT.resultset.ship_country_codedesc,
                                m_Orders_read_OUT.resultset.orders_billcountry,
                                m_Orders_read_OUT.resultset.bill_country_codedesc,
                                m_Orders_read_OUT.resultset.orders_totalprice
        FROM        orders
            INNER JOIN country bill_country ON ( orders.billcountry = bill_country.code )
INNER JOIN country ship_country ON ( orders.shipcountry = ship_country.code )
        WHERE       1=1
        AND        orders.orderid = m_Orders_read_IN.orders_orderid
    IF SQLCA.SQLCODE == NOTFOUND THEN
        LET errNo = ERROR_NOTFOUND
    END IF
    CATCH
        INITIALIZE m_Orders_read_OUT.resultset.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.Orders_read.afterRead">} {</POINT>}
    LET m_Orders_read_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Orders_read

{<BLOCK Name="fct.LineItems_read">}
#+ Read a row in the database from the given Business Record (BR) Unique Key (UK)
#+
PUBLIC FUNCTION Customers_service_LineItems_read()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.LineItems_read.define">} {</POINT>}
    {<POINT Name="fct.LineItems_read.init">} {</POINT>}
    INITIALIZE m_LineItems_read_OUT.resultset.* TO NULL
    LET errNo = ERROR_SUCCESS
    {<POINT Name="fct.LineItems_read.beforeRead">} {</POINT>}
    TRY
        SELECT      lineitem.orderid,
                                lineitem.linenum,
                                lineitem.itemid,
                                product.prodname,
                                lineitem.quantity,
                                lineitem.unitprice
        INTO        m_LineItems_read_OUT.resultset.lineitem_orderid,
                                m_LineItems_read_OUT.resultset.lineitem_linenum,
                                m_LineItems_read_OUT.resultset.lineitem_itemid,
                                m_LineItems_read_OUT.resultset.product_prodname,
                                m_LineItems_read_OUT.resultset.lineitem_quantity,
                                m_LineItems_read_OUT.resultset.lineitem_unitprice
        FROM        lineitem
            INNER JOIN item ON ( lineitem.itemid = item.itemid )
INNER JOIN product ON ( item.productid = product.productid )
        WHERE       1=1
        AND        lineitem.orderid = m_LineItems_read_IN.lineitem_orderid
        AND        lineitem.linenum = m_LineItems_read_IN.lineitem_linenum
    IF SQLCA.SQLCODE == NOTFOUND THEN
        LET errNo = ERROR_NOTFOUND
    END IF
    CATCH
        INITIALIZE m_LineItems_read_OUT.resultset.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.LineItems_read.afterRead">} {</POINT>}
    LET m_LineItems_read_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.LineItems_read

{<BLOCK Name="fct.Accounts_update">}
#+ Update rows in the database
#+
PUBLIC FUNCTION Customers_service_Accounts_update()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Accounts_update.define">} {</POINT>}
    {<POINT Name="fct.Accounts_update.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Accounts_update_IN.getLength()
        FOR i = 1 TO size
            {<POINT Name="fct.Accounts_update.beforeUpdate">} {</POINT>}
            TRY
                UPDATE account
                    SET userid = m_Accounts_update_IN[i].newData.account_userid,
                            firstname = m_Accounts_update_IN[i].newData.account_firstname,
                            lastname = m_Accounts_update_IN[i].newData.account_lastname,
                            phone = m_Accounts_update_IN[i].newData.account_phone,
                            email = m_Accounts_update_IN[i].newData.account_email
                    WHERE userid = m_Accounts_update_IN[i].keys.account_userid
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.Accounts_update.afterUpdate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Accounts_update_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Accounts_update

{<BLOCK Name="fct.Orders_update">}
#+ Update rows in the database
#+
PUBLIC FUNCTION Customers_service_Orders_update()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Orders_update.define">} {</POINT>}
    {<POINT Name="fct.Orders_update.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Orders_update_IN.getLength()
        FOR i = 1 TO size
            {<POINT Name="fct.Orders_update.beforeUpdate">} {</POINT>}
            TRY
                UPDATE orders
                    SET orderid = m_Orders_update_IN[i].newData.orders_orderid,
                            userid = m_Orders_update_IN[i].newData.orders_userid,
                            orderdate = m_Orders_update_IN[i].newData.orders_orderdate,
                            shipcountry = m_Orders_update_IN[i].newData.orders_shipcountry,
                            billcountry = m_Orders_update_IN[i].newData.orders_billcountry,
                            totalprice = m_Orders_update_IN[i].newData.orders_totalprice
                    WHERE orderid = m_Orders_update_IN[i].keys.orders_orderid
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.Orders_update.afterUpdate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Orders_update_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Orders_update

{<BLOCK Name="fct.LineItems_update">}
#+ Update rows in the database
#+
PUBLIC FUNCTION Customers_service_LineItems_update()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.LineItems_update.define">} {</POINT>}
    {<POINT Name="fct.LineItems_update.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_LineItems_update_IN.getLength()
        FOR i = 1 TO size
            {<POINT Name="fct.LineItems_update.beforeUpdate">} {</POINT>}
            TRY
                UPDATE lineitem
                    SET orderid = m_LineItems_update_IN[i].newData.lineitem_orderid,
                            linenum = m_LineItems_update_IN[i].newData.lineitem_linenum,
                            itemid = m_LineItems_update_IN[i].newData.lineitem_itemid,
                            quantity = m_LineItems_update_IN[i].newData.lineitem_quantity,
                            unitprice = m_LineItems_update_IN[i].newData.lineitem_unitprice
                    WHERE orderid = m_LineItems_update_IN[i].keys.lineitem_orderid
                        AND linenum = m_LineItems_update_IN[i].keys.lineitem_linenum
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.LineItems_update.afterUpdate">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_LineItems_update_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.LineItems_update

{<BLOCK Name="fct.Accounts_delete">}
#+ Delete rows in the database
#+
PUBLIC FUNCTION Customers_service_Accounts_delete()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Accounts_delete.define">} {</POINT>}
    {<POINT Name="fct.Accounts_delete.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Accounts_delete_IN.getLength()
        FOR i = 1 TO size
         {<POINT Name="fct.Accounts_delete.beforeDelete">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_Accounts_deleteRow(m_Accounts_delete_IN[i].*) RETURNING errNo, errMsg
         {<POINT Name="fct.Accounts_delete.afterDelete">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Accounts_delete_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Accounts_delete

{<BLOCK Name="fct.Orders_delete">}
#+ Delete rows in the database
#+
PUBLIC FUNCTION Customers_service_Orders_delete()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.Orders_delete.define">} {</POINT>}
    {<POINT Name="fct.Orders_delete.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_Orders_delete_IN.getLength()
        FOR i = 1 TO size
         {<POINT Name="fct.Orders_delete.beforeDelete">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_Orders_deleteRow(m_Orders_delete_IN[i].*) RETURNING errNo, errMsg
         {<POINT Name="fct.Orders_delete.afterDelete">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_Orders_delete_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.Orders_delete

{<BLOCK Name="fct.LineItems_delete">}
#+ Delete rows in the database
#+
PUBLIC FUNCTION Customers_service_LineItems_delete()
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE i INTEGER
    DEFINE size INTEGER
    {<POINT Name="fct.LineItems_delete.define">} {</POINT>}
    {<POINT Name="fct.LineItems_delete.init">} {</POINT>}
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        LET size = m_LineItems_delete_IN.getLength()
        FOR i = 1 TO size
         {<POINT Name="fct.LineItems_delete.beforeDelete">} {</POINT>}
            CALL Customers_uidata.Customers_uidata_LineItems_deleteRow(m_LineItems_delete_IN[i].*) RETURNING errNo, errMsg
         {<POINT Name="fct.LineItems_delete.afterDelete">} {</POINT>}
            IF errNo != ERROR_SUCCESS THEN
                EXIT FOR
            END IF
        END FOR
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    LET m_LineItems_delete_OUT.errNo = errNo
END FUNCTION
{</BLOCK>} --fct.LineItems_delete

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
