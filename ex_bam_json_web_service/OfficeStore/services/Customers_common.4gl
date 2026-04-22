#+ JSON Web service - Common

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

-- Database schema
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

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_Accounts_arrKeyRec DYNAMIC ARRAY OF Accounts_br_uk_type
PUBLIC DEFINE m_Accounts_arrRecGrid DYNAMIC ARRAY OF Accounts_br_type
PUBLIC DEFINE m_Accounts_arrRecDB DYNAMIC ARRAY OF RECORD LIKE account.*
PUBLIC DEFINE m_Accounts_keyIndex INTEGER
PUBLIC DEFINE m_Accounts_lookup Accounts_br_type
PUBLIC DEFINE m_Orders_arrKeyRec DYNAMIC ARRAY OF Orders_br_uk_type
PUBLIC DEFINE m_Orders_arrRecGrid DYNAMIC ARRAY OF Orders_br_type
PUBLIC DEFINE m_Orders_arrRecDB DYNAMIC ARRAY OF RECORD LIKE orders.*
PUBLIC DEFINE m_Orders_keyIndex INTEGER
PUBLIC DEFINE m_Orders_lookup Orders_br_type
PUBLIC DEFINE m_LineItems_arrKeyRec DYNAMIC ARRAY OF LineItems_br_uk_type
PUBLIC DEFINE m_LineItems_arrRecGrid DYNAMIC ARRAY OF LineItems_br_type
PUBLIC DEFINE m_LineItems_arrRecDB DYNAMIC ARRAY OF RECORD LIKE lineitem.*
PUBLIC DEFINE m_LineItems_keyIndex INTEGER
PUBLIC DEFINE m_LineItems_lookup LineItems_br_type
