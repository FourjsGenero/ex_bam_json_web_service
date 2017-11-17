{<CODEFILE Path="Customers.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ JSON Web service client

--------------------------------------------------------------------------------
--This code is generated with the template dbapp4.1
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
--Import Genero Web Service COM library
IMPORT com
IMPORT util
IMPORT FGL libdbappWSCore
IMPORT FGL libdbappWSClient
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA officestore

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE HTTPResponseStatus RECORD
        code INTEGER,
        description STRING
END RECORD

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

PUBLIC TYPE createAll_IN_type DYNAMIC ARRAY OF RECORD
    AccountsData Accounts_ws_br_type,
    detail_Orders DYNAMIC ARRAY OF RECORD
        OrdersData Orders_ws_br_type,
        detail_LineItems DYNAMIC ARRAY OF RECORD
            LineItemsData LineItems_ws_br_type
        END RECORD
    END RECORD
END RECORD

PUBLIC TYPE createAll_OUT_type RECORD
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

PUBLIC TYPE readAll_IN_type ws_br_qbe_type

PUBLIC TYPE readAll_OUT_type RECORD
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

PUBLIC TYPE Accounts_create_IN_type DYNAMIC ARRAY OF Accounts_ws_br_type

PUBLIC TYPE Accounts_create_OUT_type RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF Accounts_ws_br_uk_type
END RECORD

PUBLIC TYPE Orders_create_IN_type DYNAMIC ARRAY OF Orders_ws_br_type

PUBLIC TYPE Orders_create_OUT_type RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF Orders_ws_br_uk_type
END RECORD

PUBLIC TYPE LineItems_create_IN_type DYNAMIC ARRAY OF LineItems_ws_br_type

PUBLIC TYPE LineItems_create_OUT_type RECORD
    errNo INTEGER,
    keys DYNAMIC ARRAY OF LineItems_ws_br_uk_type
END RECORD

PUBLIC TYPE Accounts_read_IN_type Accounts_ws_br_uk_type

PUBLIC TYPE Accounts_read_OUT_type RECORD
    errNo INTEGER,
    resultset Accounts_ws_br_type
END RECORD

PUBLIC TYPE Orders_read_IN_type Orders_ws_br_uk_type

PUBLIC TYPE Orders_read_OUT_type RECORD
    errNo INTEGER,
    resultset Orders_ws_br_type
END RECORD

PUBLIC TYPE LineItems_read_IN_type LineItems_ws_br_uk_type

PUBLIC TYPE LineItems_read_OUT_type RECORD
    errNo INTEGER,
    resultset LineItems_ws_br_type
END RECORD

PUBLIC TYPE Accounts_update_IN_type DYNAMIC ARRAY OF RECORD
    keys Accounts_ws_br_uk_type,
    newData Accounts_ws_br_type
END RECORD

PUBLIC TYPE Accounts_update_OUT_type RECORD
    errNo INTEGER
END RECORD

PUBLIC TYPE Orders_update_IN_type DYNAMIC ARRAY OF RECORD
    keys Orders_ws_br_uk_type,
    newData Orders_ws_br_type
END RECORD

PUBLIC TYPE Orders_update_OUT_type RECORD
    errNo INTEGER
END RECORD

PUBLIC TYPE LineItems_update_IN_type DYNAMIC ARRAY OF RECORD
    keys LineItems_ws_br_uk_type,
    newData LineItems_ws_br_type
END RECORD

PUBLIC TYPE LineItems_update_OUT_type RECORD
    errNo INTEGER
END RECORD

PUBLIC TYPE Accounts_delete_IN_type DYNAMIC ARRAY OF Accounts_ws_br_uk_type

PUBLIC TYPE Accounts_delete_OUT_type RECORD
    errNo INTEGER
END RECORD

PUBLIC TYPE Orders_delete_IN_type DYNAMIC ARRAY OF Orders_ws_br_uk_type

PUBLIC TYPE Orders_delete_OUT_type RECORD
    errNo INTEGER
END RECORD

PUBLIC TYPE LineItems_delete_IN_type DYNAMIC ARRAY OF LineItems_ws_br_uk_type

PUBLIC TYPE LineItems_delete_OUT_type RECORD
    errNo INTEGER
END RECORD

{<POINT Name="define">} {</POINT>}

{<BLOCK Name="fct.createAll">}
#+ Creates documents via JSON Web Service.
#+ A document is formed of a Accounts row, Orders rows, LineItems rows
#+
#+ @param documents documents
#+
#+ @returnType INTEGER, STRING, INTEGER, DYNAMIC ARRAY of document keys
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return document keys created
#+
FUNCTION Customers_client_createAll(documents)
    DEFINE documents createAll_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE createAll_OUT createAll_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.createAll.define">} {</POINT>}

    INITIALIZE createAll_OUT TO NULL
    {<POINT Name="fct.createAll.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(documents))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), createAll_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, createAll_OUT.*
END FUNCTION
{</BLOCK>} --fct.createAll

{<BLOCK Name="fct.readAll">}
#+ Reads documents via JSON Web Service.
#+ A document is formed of a Accounts row, Orders rows, LineItems rows
#+
#+ @param qbe QBE criteria
#+
#+ @returnType INTEGER, STRING, INTEGER, DYNAMIC ARRAY of documents
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return documents fetched
#+
FUNCTION Customers_client_readAll(qbe)
    DEFINE qbe readAll_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE readAll_OUT readAll_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.readAll.define">} {</POINT>}

    INITIALIZE readAll_OUT TO NULL
    {<POINT Name="fct.readAll.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "READCollection")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(qbe))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), readAll_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, readAll_OUT.*
END FUNCTION
{</BLOCK>} --fct.readAll

{<BLOCK Name="fct.Accounts_create">}
#+ Creates Accounts rows via JSON Web Service.
#+
#+ @param rows Accounts rows
#+
#+ @returnType INTEGER, STRING, INTEGER, DYNAMIC ARRAY OF Accounts_ws_br_uk_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return Accounts keys created
#+
FUNCTION Customers_client_Accounts_create(rows)
    DEFINE rows Accounts_create_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE create_OUT Accounts_create_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Accounts_create.define">} {</POINT>}

    INITIALIZE create_OUT TO NULL
    {<POINT Name="fct.Accounts_create.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(rows))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), create_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, create_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_create

{<BLOCK Name="fct.Orders_create">}
#+ Creates Orders rows via JSON Web Service.
#+
#+ @param rows Orders rows
#+
#+ @returnType INTEGER, STRING, INTEGER, DYNAMIC ARRAY OF Orders_ws_br_uk_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return Orders keys created
#+
FUNCTION Customers_client_Orders_create(rows)
    DEFINE rows Orders_create_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE create_OUT Orders_create_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Orders_create.define">} {</POINT>}

    INITIALIZE create_OUT TO NULL
    {<POINT Name="fct.Orders_create.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(rows))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), create_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, create_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_create

{<BLOCK Name="fct.LineItems_create">}
#+ Creates LineItems rows via JSON Web Service.
#+
#+ @param rows LineItems rows
#+
#+ @returnType INTEGER, STRING, INTEGER, DYNAMIC ARRAY OF LineItems_ws_br_uk_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return LineItems keys created
#+
FUNCTION Customers_client_LineItems_create(rows)
    DEFINE rows LineItems_create_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE create_OUT LineItems_create_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.LineItems_create.define">} {</POINT>}

    INITIALIZE create_OUT TO NULL
    {<POINT Name="fct.LineItems_create.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(rows))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), create_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, create_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_create

{<BLOCK Name="fct.Accounts_readRow">}
#+ Reads a Accounts row via JSON Web Service.
#+
#+ @param key a Accounts key
#+
#+ @returnType INTEGER, STRING, INTEGER, Accounts_ws_br_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return Accounts row fetched
#+
FUNCTION Customers_client_Accounts_readRow(key)
    DEFINE key Accounts_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE read_OUT Accounts_read_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Accounts_readRow.define">} {</POINT>}

    INITIALIZE read_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Accounts_readRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.account_userid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("GET")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), read_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, read_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_readRow

{<BLOCK Name="fct.Orders_readRow">}
#+ Reads a Orders row via JSON Web Service.
#+
#+ @param key a Orders key
#+
#+ @returnType INTEGER, STRING, INTEGER, Orders_ws_br_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return Orders row fetched
#+
FUNCTION Customers_client_Orders_readRow(key)
    DEFINE key Orders_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE read_OUT Orders_read_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Orders_readRow.define">} {</POINT>}

    INITIALIZE read_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Orders_readRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.orders_orderid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("GET")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), read_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, read_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_readRow

{<BLOCK Name="fct.LineItems_readRow">}
#+ Reads a LineItems row via JSON Web Service.
#+
#+ @param key a LineItems key
#+
#+ @returnType INTEGER, STRING, INTEGER, LineItems_ws_br_type
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+ @return LineItems row fetched
#+
FUNCTION Customers_client_LineItems_readRow(key)
    DEFINE key LineItems_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE read_OUT LineItems_read_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.LineItems_readRow.define">} {</POINT>}

    INITIALIZE read_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.LineItems_readRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_orderid
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_linenum
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("GET")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), read_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, read_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_readRow

{<BLOCK Name="fct.Accounts_update">}
#+ Updates Accounts rows via JSON Web Service.
#+
#+ @param keysAndData Accounts keys and new data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Accounts_update(keysAndData)
    DEFINE keysAndData Accounts_update_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT Accounts_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Accounts_update.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    {<POINT Name="fct.Accounts_update.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "UPDATECollection")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(keysAndData))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_update

{<BLOCK Name="fct.Accounts_updateRow">}
#+ Updates a Accounts row via JSON Web Service.
#+
#+ @param key a Accounts key
#+ @param data new Accounts data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Accounts_updateRow(key, data)
    DEFINE key Accounts_ws_br_uk_type
    DEFINE data Accounts_ws_br_data_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT Accounts_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Accounts_updateRow.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Accounts_updateRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.account_userid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(data))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
                CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_updateRow

{<BLOCK Name="fct.Orders_update">}
#+ Updates Orders rows via JSON Web Service.
#+
#+ @param keysAndData Orders keys and new data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Orders_update(keysAndData)
    DEFINE keysAndData Orders_update_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT Orders_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Orders_update.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    {<POINT Name="fct.Orders_update.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "UPDATECollection")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(keysAndData))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_update

{<BLOCK Name="fct.Orders_updateRow">}
#+ Updates a Orders row via JSON Web Service.
#+
#+ @param key a Orders key
#+ @param data new Orders data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Orders_updateRow(key, data)
    DEFINE key Orders_ws_br_uk_type
    DEFINE data Orders_ws_br_data_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT Orders_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Orders_updateRow.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Orders_updateRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.orders_orderid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(data))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
                CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_updateRow

{<BLOCK Name="fct.LineItems_update">}
#+ Updates LineItems rows via JSON Web Service.
#+
#+ @param keysAndData LineItems keys and new data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_LineItems_update(keysAndData)
    DEFINE keysAndData LineItems_update_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT LineItems_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.LineItems_update.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    {<POINT Name="fct.LineItems_update.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "UPDATECollection")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(keysAndData))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_update

{<BLOCK Name="fct.LineItems_updateRow">}
#+ Updates a LineItems row via JSON Web Service.
#+
#+ @param key a LineItems key
#+ @param data new LineItems data
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_LineItems_updateRow(key, data)
    DEFINE key LineItems_ws_br_uk_type
    DEFINE data LineItems_ws_br_data_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE update_OUT LineItems_update_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.LineItems_updateRow.define">} {</POINT>}

    INITIALIZE update_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.LineItems_updateRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_orderid
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_linenum
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("PUT")
        CALL req.doTextRequest(util.JSON.stringify(data))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
                CALL util.JSON.parse(resp.getTextResponse(), update_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, update_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_updateRow

{<BLOCK Name="fct.Accounts_delete">}
#+ Deletes Accounts rows via JSON Web Service.
#+
#+ @param keys Accounts keys
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Accounts_delete(keys)
    DEFINE keys Accounts_delete_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT Accounts_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Accounts_delete.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    {<POINT Name="fct.Accounts_delete.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "DELETECollection")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(keys))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_delete

{<BLOCK Name="fct.Accounts_deleteRow">}
#+ Deletes a Accounts row via JSON Web Service.
#+
#+ @param key a Accounts key
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Accounts_deleteRow(key)
    DEFINE key Accounts_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT Accounts_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Accounts_deleteRow.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Accounts_deleteRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.account_userid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("DELETE")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.Accounts_deleteRow

{<BLOCK Name="fct.Orders_delete">}
#+ Deletes Orders rows via JSON Web Service.
#+
#+ @param keys Orders keys
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Orders_delete(keys)
    DEFINE keys Orders_delete_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT Orders_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.Orders_delete.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    {<POINT Name="fct.Orders_delete.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "DELETECollection")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(keys))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_delete

{<BLOCK Name="fct.Orders_deleteRow">}
#+ Deletes a Orders row via JSON Web Service.
#+
#+ @param key a Orders key
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_Orders_deleteRow(key)
    DEFINE key Orders_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT Orders_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.Orders_deleteRow.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.Orders_deleteRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.orders_orderid
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("DELETE")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.Orders_deleteRow

{<BLOCK Name="fct.LineItems_delete">}
#+ Deletes LineItems rows via JSON Web Service.
#+
#+ @param keys LineItems keys
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_LineItems_delete(keys)
    DEFINE keys LineItems_delete_IN_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT LineItems_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    {<POINT Name="fct.LineItems_delete.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    {<POINT Name="fct.LineItems_delete.init">} {</POINT>}

    TRY
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", NULL)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setHeader("CRUDOperation", "DELETECollection")
        CALL req.setMethod("POST")
        CALL req.doTextRequest(util.JSON.stringify(keys))
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_delete

{<BLOCK Name="fct.LineItems_deleteRow">}
#+ Deletes a LineItems row via JSON Web Service.
#+
#+ @param key a LineItems key
#+
#+ @returnType INTEGER, STRING, INTEGER
#+ @return an HTTP status code
#+ @return an HTTP status description
#+ @return an application error number
#+
FUNCTION Customers_client_LineItems_deleteRow(key)
    DEFINE key LineItems_ws_br_uk_type
    DEFINE respStatus HTTPResponseStatus
    DEFINE delete_OUT LineItems_delete_OUT_type

    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE urlString STRING
    DEFINE keyList DYNAMIC ARRAY OF STRING
    {<POINT Name="fct.LineItems_deleteRow.define">} {</POINT>}

    INITIALIZE delete_OUT TO NULL
    INITIALIZE keyList TO NULL
    {<POINT Name="fct.LineItems_deleteRow.init">} {</POINT>}

    TRY
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_orderid
        CALL keyList.appendElement()
        LET keyList[keyList.getLength()] = key.lineitem_linenum
        LET urlString = libdbappWSClient.createURL("Customers/Accounts/Orders/LineItems", keyList)
        LET req = com.HTTPRequest.Create(urlString)
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.setMethod("DELETE")
        CALL req.doRequest()
        LET resp = req.getResponse()
        LET respStatus.code = resp.getStatusCode()
        LET respStatus.description = resp.getStatusDescription()
        --HTTP OK
        IF respStatus.code == 200 THEN
            CALL util.JSON.parse(resp.getTextResponse(), delete_OUT)
        END IF
    CATCH
        LET respStatus.code = STATUS
        LET respStatus.description = SQLCA.SQLERRM
    END TRY

    RETURN respStatus.*, delete_OUT.*
END FUNCTION
{</BLOCK>} --fct.LineItems_deleteRow

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
