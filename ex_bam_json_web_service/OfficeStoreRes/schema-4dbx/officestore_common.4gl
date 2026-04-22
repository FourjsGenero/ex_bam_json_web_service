#+ DB schema - Common (officestore)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

-- Database schema
SCHEMA officestore

-- PRIMARY KEY TYPES - TABLE LEVEL

PUBLIC TYPE supplier_pk
    RECORD
        supplier_suppid LIKE supplier.suppid
    END RECORD

PUBLIC TYPE signon_pk
    RECORD
        signon_userid LIKE signon.userid
    END RECORD

PUBLIC TYPE seqreg_pk
    RECORD
        seqreg_sr_name LIKE seqreg.sr_name
    END RECORD

PUBLIC TYPE product_pk
    RECORD
        product_productid LIKE product.productid
    END RECORD

PUBLIC TYPE orderstatus_pk
    RECORD
        orderstatus_orderid LIKE orderstatus.orderid,
        orderstatus_linenum LIKE orderstatus.linenum
    END RECORD

PUBLIC TYPE orders_pk
    RECORD
        orders_orderid LIKE orders.orderid
    END RECORD

PUBLIC TYPE lineitem_pk
    RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum
    END RECORD

PUBLIC TYPE item_pk
    RECORD
        item_itemid LIKE item.itemid
    END RECORD

PUBLIC TYPE inventory_pk
    RECORD
        inventory_itemid LIKE inventory.itemid
    END RECORD

PUBLIC TYPE country_pk
    RECORD
        country_code LIKE country.code
    END RECORD

PUBLIC TYPE category_pk
    RECORD
        category_catid LIKE category.catid
    END RECORD

PUBLIC TYPE account_pk
    RECORD
        account_userid LIKE account.userid
    END RECORD
