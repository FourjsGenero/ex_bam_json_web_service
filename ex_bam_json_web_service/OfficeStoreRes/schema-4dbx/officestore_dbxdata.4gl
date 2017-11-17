{<CODEFILE Path="officestore.code" Hash="I8m3aGrSGKizhnuFc+N0sQ==" />}
#+ DB schema - Data Management (officestore)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp4.1
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql

IMPORT FGL officestore_dbxconstraints
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA officestore

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.supplier_pk_supplier_selectRowByKey">}
#+ Select a row identified by the primary key in the "supplier" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE supplier.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE supplier.*
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE supplier.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.supplier_pk_supplier_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.supplier_pk_supplier_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM supplier
                WHERE supplier.suppid = p_key.supplier_suppid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM supplier
                WHERE supplier.suppid = p_key.supplier_suppid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.supplier_pk_supplier_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_selectRowByKey

{<BLOCK Name="fct.supplier_insertRowByKey">}
#+ Insert a row in the "supplier" table and return the primary key created
#+
#+ @param p_data - a row data LIKE supplier.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, supplier.suppid
PRIVATE FUNCTION officestore_dbxdata_supplier_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE supplier.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.supplier_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("supplier") RETURNING errNo, p_data.suppid
        {<POINT Name="fct.supplier_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            CALL officestore_dbxconstraints.officestore_dbxconstraints_supplier_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            {<POINT Name="fct.supplier_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO supplier VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.suppid) RETURNING p_data.suppid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                {<POINT Name="fct.supplier_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.suppid
END FUNCTION
{</BLOCK>} --fct.supplier_insertRowByKey

{<BLOCK Name="fct.supplier_pk_supplier_insertRowByKey">}
#+ Insert a row in the "supplier" table and return the table keys
#+
#+ @param p_data - a row data LIKE supplier.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, supplier.suppid
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE supplier.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.supplier_pk_supplier_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.supplier_pk_supplier_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_supplier_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.suppid
    RETURN errNo, errMsg, p_data.suppid
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_insertRowByKey

{<BLOCK Name="fct.supplier_pk_supplier_updateRowByKey">}
#+ Update a row identified by the primary key in the "supplier" table
#+
#+ @param p_dataT0 - a row data LIKE supplier.*
#+ @param p_dataT1 - a row data LIKE supplier.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE supplier.*
    DEFINE p_dataT1 RECORD LIKE supplier.*
    DEFINE l_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.supplier_pk_supplier_updateRowByKey.define">} {</POINT>}
    LET l_key.supplier_suppid = p_dataT0.suppid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.supplier_pk_supplier_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_supplier_pk_supplier_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.supplier_pk_supplier_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_supplier_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.supplier_pk_supplier_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE supplier
                        SET supplier.* = p_dataT1.*
                        WHERE supplier.suppid = l_key.supplier_suppid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.supplier_pk_supplier_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_updateRowByKey

{<BLOCK Name="fct.supplier_pk_supplier_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "supplier" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.supplier_pk_supplier_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.supplier_pk_supplier_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM supplier
                    WHERE supplier.suppid = p_key.supplier_suppid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.supplier_pk_supplier_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_deleteRowByKey

{<BLOCK Name="fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "supplier" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE supplier.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE supplier.*
    DEFINE l_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.supplier_suppid = p_dataT0.suppid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_supplier_pk_supplier_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_supplier_pk_supplier_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "supplier" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE supplier.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE supplier.*
    DEFINE l_dataT2 RECORD LIKE supplier.*
    DEFINE l_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.supplier_suppid = p_dataT0.suppid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_supplier_pk_supplier_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.supplier_pk_supplier_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "supplier" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE l_data RECORD LIKE supplier.*
    DEFINE l_key_fk_item_supplier
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.supplier_pk_supplier_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.supplier_pk_supplier_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_supplier_pk_supplier_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_item_supplier
            LET l_sqlQuery = "SELECT itemid FROM item WHERE item.supplier = ?"
            TRY
                DECLARE officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey_fk_item_supplier CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey_fk_item_supplier
                    USING l_data.suppid
                FETCH officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey_fk_item_supplier
                    INTO l_key_fk_item_supplier.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_supplier_pk_supplier_deleteReferencingRowsByKey_fk_item_supplier
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.supplier_pk_supplier_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_deleteReferencingRowsByKey

{<BLOCK Name="fct.supplier_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_supplier_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE supplier.*
    {<POINT Name="fct.supplier_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.supplier_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.supplier_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.signon_pk_signon_selectRowByKey">}
#+ Select a row identified by the primary key in the "signon" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE signon.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE signon.*
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE signon.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.signon_pk_signon_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.signon_pk_signon_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM signon
                WHERE signon.userid = p_key.signon_userid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM signon
                WHERE signon.userid = p_key.signon_userid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.signon_pk_signon_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_selectRowByKey

{<BLOCK Name="fct.signon_insertRowByKey">}
#+ Insert a row in the "signon" table and return the primary key created
#+
#+ @param p_data - a row data LIKE signon.*
#+
#+ @returnType INTEGER, STRING, CHAR(80)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, signon.userid
PRIVATE FUNCTION officestore_dbxdata_signon_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE signon.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.signon_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.signon_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_signon_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.signon_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO signon VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.signon_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.userid
END FUNCTION
{</BLOCK>} --fct.signon_insertRowByKey

{<BLOCK Name="fct.signon_pk_signon_insertRowByKey">}
#+ Insert a row in the "signon" table and return the table keys
#+
#+ @param p_data - a row data LIKE signon.*
#+
#+ @returnType INTEGER, STRING, CHAR(80)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, signon.userid
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE signon.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.signon_pk_signon_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.signon_pk_signon_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_signon_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.userid
    RETURN errNo, errMsg, p_data.userid
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_insertRowByKey

{<BLOCK Name="fct.signon_pk_signon_updateRowByKey">}
#+ Update a row identified by the primary key in the "signon" table
#+
#+ @param p_dataT0 - a row data LIKE signon.*
#+ @param p_dataT1 - a row data LIKE signon.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE signon.*
    DEFINE p_dataT1 RECORD LIKE signon.*
    DEFINE l_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.signon_pk_signon_updateRowByKey.define">} {</POINT>}
    LET l_key.signon_userid = p_dataT0.userid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.signon_pk_signon_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_signon_pk_signon_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.signon_pk_signon_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_signon_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.signon_pk_signon_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE signon
                        SET signon.* = p_dataT1.*
                        WHERE signon.userid = l_key.signon_userid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.signon_pk_signon_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_updateRowByKey

{<BLOCK Name="fct.signon_pk_signon_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "signon" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.signon_pk_signon_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.signon_pk_signon_deleteRowByKey.init">} {</POINT>}
        TRY
            DELETE FROM signon
                WHERE signon.userid = p_key.signon_userid
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.signon_pk_signon_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_deleteRowByKey

{<BLOCK Name="fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "signon" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE signon.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE signon.*
    DEFINE l_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.signon_userid = p_dataT0.userid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_signon_pk_signon_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_signon_pk_signon_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "signon" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE signon.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_signon_pk_signon_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE signon.*
    DEFINE l_dataT2 RECORD LIKE signon.*
    DEFINE l_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.signon_userid = p_dataT0.userid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_signon_pk_signon_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.signon_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_signon_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE signon.*
    {<POINT Name="fct.signon_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.signon_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.signon_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.seqreg_pk_seqreg_selectRowByKey">}
#+ Select a row identified by the primary key in the "seqreg" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE seqreg.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE seqreg.*
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE seqreg.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM seqreg
                WHERE seqreg.sr_name = p_key.seqreg_sr_name
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM seqreg
                WHERE seqreg.sr_name = p_key.seqreg_sr_name
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_selectRowByKey

{<BLOCK Name="fct.seqreg_insertRowByKey">}
#+ Insert a row in the "seqreg" table and return the primary key created
#+
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING, VARCHAR(30)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, seqreg.sr_name
PRIVATE FUNCTION officestore_dbxdata_seqreg_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_seqreg_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.seqreg_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO seqreg VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.seqreg_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.sr_name
END FUNCTION
{</BLOCK>} --fct.seqreg_insertRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_insertRowByKey">}
#+ Insert a row in the "seqreg" table and return the table keys
#+
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING, VARCHAR(30)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, seqreg.sr_name
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_pk_seqreg_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.seqreg_pk_seqreg_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_seqreg_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.sr_name
    RETURN errNo, errMsg, p_data.sr_name
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_insertRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_updateRowByKey">}
#+ Update a row identified by the primary key in the "seqreg" table
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+ @param p_dataT1 - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE p_dataT1 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.define">} {</POINT>}
    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_seqreg_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE seqreg
                        SET seqreg.* = p_dataT1.*
                        WHERE seqreg.sr_name = l_key.seqreg_sr_name
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_updateRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "seqreg" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.init">} {</POINT>}
        TRY
            DELETE FROM seqreg
                WHERE seqreg.sr_name = p_key.seqreg_sr_name
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_deleteRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "seqreg" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_seqreg_pk_seqreg_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "seqreg" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE l_dataT2 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_seqreg_pk_seqreg_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.seqreg_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_seqreg_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE seqreg.*
    {<POINT Name="fct.seqreg_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.seqreg_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.seqreg_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.product_pk_product_selectRowByKey">}
#+ Select a row identified by the primary key in the "product" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE product.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE product.*
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE product.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.product_pk_product_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.product_pk_product_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM product
                WHERE product.productid = p_key.product_productid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM product
                WHERE product.productid = p_key.product_productid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.product_pk_product_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.product_pk_product_selectRowByKey

{<BLOCK Name="fct.product_insertRowByKey">}
#+ Insert a row in the "product" table and return the primary key created
#+
#+ @param p_data - a row data LIKE product.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, product.productid
PRIVATE FUNCTION officestore_dbxdata_product_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE product.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.product_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.product_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_product_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.product_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO product VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.product_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.productid
END FUNCTION
{</BLOCK>} --fct.product_insertRowByKey

{<BLOCK Name="fct.product_pk_product_insertRowByKey">}
#+ Insert a row in the "product" table and return the table keys
#+
#+ @param p_data - a row data LIKE product.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, product.productid
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE product.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.product_pk_product_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.product_pk_product_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_product_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.productid
    RETURN errNo, errMsg, p_data.productid
END FUNCTION
{</BLOCK>} --fct.product_pk_product_insertRowByKey

{<BLOCK Name="fct.product_pk_product_updateRowByKey">}
#+ Update a row identified by the primary key in the "product" table
#+
#+ @param p_dataT0 - a row data LIKE product.*
#+ @param p_dataT1 - a row data LIKE product.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE product.*
    DEFINE p_dataT1 RECORD LIKE product.*
    DEFINE l_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.product_pk_product_updateRowByKey.define">} {</POINT>}
    LET l_key.product_productid = p_dataT0.productid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.product_pk_product_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_product_pk_product_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.product_pk_product_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_product_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.product_pk_product_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE product
                        SET product.* = p_dataT1.*
                        WHERE product.productid = l_key.product_productid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.product_pk_product_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_pk_product_updateRowByKey

{<BLOCK Name="fct.product_pk_product_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "product" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.product_pk_product_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.product_pk_product_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM product
                    WHERE product.productid = p_key.product_productid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.product_pk_product_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.product_pk_product_deleteRowByKey

{<BLOCK Name="fct.product_pk_product_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "product" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE product.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE product.*
    DEFINE l_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.product_pk_product_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.product_productid = p_dataT0.productid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.product_pk_product_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_product_pk_product_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.product_pk_product_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_product_pk_product_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.product_pk_product_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.product_pk_product_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.product_pk_product_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "product" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE product.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE product.*
    DEFINE l_dataT2 RECORD LIKE product.*
    DEFINE l_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.product_pk_product_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.product_productid = p_dataT0.productid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.product_pk_product_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_product_pk_product_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.product_pk_product_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.product_pk_product_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.product_pk_product_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.product_pk_product_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "product" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE l_data RECORD LIKE product.*
    DEFINE l_key_fk_item_product
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.product_pk_product_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.product_pk_product_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_product_pk_product_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_item_product
            LET l_sqlQuery = "SELECT itemid FROM item WHERE item.productid = ?"
            TRY
                DECLARE officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey_fk_item_product CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey_fk_item_product
                    USING l_data.productid
                FETCH officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey_fk_item_product
                    INTO l_key_fk_item_product.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_product_pk_product_deleteReferencingRowsByKey_fk_item_product
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.product_pk_product_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.product_pk_product_deleteReferencingRowsByKey

{<BLOCK Name="fct.product_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_product_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE product.*
    {<POINT Name="fct.product_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.product_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.product_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.orderstatus_pk_orderstatus_selectRowByKey">}
#+ Select a row identified by the primary key in the "orderstatus" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE orderstatus.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE orderstatus.*
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE orderstatus.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.orderstatus_pk_orderstatus_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM orderstatus
                WHERE orderstatus.orderid = p_key.orderstatus_orderid
                    AND orderstatus.linenum = p_key.orderstatus_linenum
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM orderstatus
                WHERE orderstatus.orderid = p_key.orderstatus_orderid
                AND orderstatus.linenum = p_key.orderstatus_linenum
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.orderstatus_pk_orderstatus_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_selectRowByKey

{<BLOCK Name="fct.orderstatus_insertRowByKey">}
#+ Insert a row in the "orderstatus" table and return the primary key created
#+
#+ @param p_data - a row data LIKE orderstatus.*
#+
#+ @returnType INTEGER, STRING, INTEGER, INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, orderstatus.orderid, orderstatus.linenum
PRIVATE FUNCTION officestore_dbxdata_orderstatus_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE orderstatus.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orderstatus_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orderstatus_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_orderstatus_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.orderstatus_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO orderstatus VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.orderstatus_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.orderid, p_data.linenum
END FUNCTION
{</BLOCK>} --fct.orderstatus_insertRowByKey

{<BLOCK Name="fct.orderstatus_pk_orderstatus_insertRowByKey">}
#+ Insert a row in the "orderstatus" table and return the table keys
#+
#+ @param p_data - a row data LIKE orderstatus.*
#+
#+ @returnType INTEGER, STRING, INTEGER, INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, orderstatus.orderid, orderstatus.linenum
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE orderstatus.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orderstatus_pk_orderstatus_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.orderstatus_pk_orderstatus_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_orderstatus_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.orderid, p_data.linenum
    RETURN errNo, errMsg, p_data.orderid, p_data.linenum
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_insertRowByKey

{<BLOCK Name="fct.orderstatus_pk_orderstatus_updateRowByKey">}
#+ Update a row identified by the primary key in the "orderstatus" table
#+
#+ @param p_dataT0 - a row data LIKE orderstatus.*
#+ @param p_dataT1 - a row data LIKE orderstatus.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE orderstatus.*
    DEFINE p_dataT1 RECORD LIKE orderstatus.*
    DEFINE l_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orderstatus_pk_orderstatus_updateRowByKey.define">} {</POINT>}
    LET l_key.orderstatus_orderid = p_dataT0.orderid
    LET l_key.orderstatus_linenum = p_dataT0.linenum
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orderstatus_pk_orderstatus_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.orderstatus_pk_orderstatus_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_orderstatus_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.orderstatus_pk_orderstatus_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE orderstatus
                        SET orderstatus.* = p_dataT1.*
                        WHERE orderstatus.orderid = l_key.orderstatus_orderid
                        AND orderstatus.linenum = l_key.orderstatus_linenum
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.orderstatus_pk_orderstatus_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_updateRowByKey

{<BLOCK Name="fct.orderstatus_pk_orderstatus_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "orderstatus" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKey.init">} {</POINT>}
        TRY
            DELETE FROM orderstatus
                WHERE orderstatus.orderid = p_key.orderstatus_orderid
                AND orderstatus.linenum = p_key.orderstatus_linenum
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_deleteRowByKey

{<BLOCK Name="fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "orderstatus" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE orderstatus.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE orderstatus.*
    DEFINE l_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.orderstatus_orderid = p_dataT0.orderid
    LET l_key.orderstatus_linenum = p_dataT0.linenum
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_orderstatus_pk_orderstatus_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "orderstatus" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE orderstatus.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE orderstatus.*
    DEFINE l_dataT2 RECORD LIKE orderstatus.*
    DEFINE l_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.orderstatus_orderid = p_dataT0.orderid
    LET l_key.orderstatus_linenum = p_dataT0.linenum
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_orderstatus_pk_orderstatus_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.orderstatus_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_orderstatus_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE orderstatus.*
    {<POINT Name="fct.orderstatus_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.orderstatus_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.orderstatus_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.orders_pk_orders_selectRowByKey">}
#+ Select a row identified by the primary key in the "orders" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE orders.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE orders.*
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE orders.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.orders_pk_orders_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.orders_pk_orders_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM orders
                WHERE orders.orderid = p_key.orders_orderid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM orders
                WHERE orders.orderid = p_key.orders_orderid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.orders_pk_orders_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_selectRowByKey

{<BLOCK Name="fct.orders_insertRowByKey">}
#+ Insert a row in the "orders" table and return the primary key created
#+
#+ @param p_data - a row data LIKE orders.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, orders.orderid
PRIVATE FUNCTION officestore_dbxdata_orders_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE orders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orders_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("orders") RETURNING errNo, p_data.orderid
        {<POINT Name="fct.orders_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            CALL officestore_dbxconstraints.officestore_dbxconstraints_orders_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            {<POINT Name="fct.orders_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO orders VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.orderid) RETURNING p_data.orderid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                {<POINT Name="fct.orders_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.orderid
END FUNCTION
{</BLOCK>} --fct.orders_insertRowByKey

{<BLOCK Name="fct.orders_pk_orders_insertRowByKey">}
#+ Insert a row in the "orders" table and return the table keys
#+
#+ @param p_data - a row data LIKE orders.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, orders.orderid
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE orders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orders_pk_orders_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.orders_pk_orders_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_orders_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.orderid
    RETURN errNo, errMsg, p_data.orderid
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_insertRowByKey

{<BLOCK Name="fct.orders_pk_orders_updateRowByKey">}
#+ Update a row identified by the primary key in the "orders" table
#+
#+ @param p_dataT0 - a row data LIKE orders.*
#+ @param p_dataT1 - a row data LIKE orders.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE orders.*
    DEFINE p_dataT1 RECORD LIKE orders.*
    DEFINE l_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.orders_pk_orders_updateRowByKey.define">} {</POINT>}
    LET l_key.orders_orderid = p_dataT0.orderid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orders_pk_orders_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_orders_pk_orders_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.orders_pk_orders_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_orders_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.orders_pk_orders_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE orders
                        SET orders.* = p_dataT1.*
                        WHERE orders.orderid = l_key.orders_orderid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.orders_pk_orders_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_updateRowByKey

{<BLOCK Name="fct.orders_pk_orders_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "orders" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.orders_pk_orders_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orders_pk_orders_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM orders
                    WHERE orders.orderid = p_key.orders_orderid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.orders_pk_orders_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_deleteRowByKey

{<BLOCK Name="fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "orders" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE orders.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE orders.*
    DEFINE l_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.orders_orderid = p_dataT0.orderid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_orders_pk_orders_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_orders_pk_orders_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "orders" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE orders.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE orders.*
    DEFINE l_dataT2 RECORD LIKE orders.*
    DEFINE l_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.orders_orderid = p_dataT0.orderid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_orders_pk_orders_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.orders_pk_orders_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "orders" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_data RECORD LIKE orders.*
    DEFINE l_key_fk_orderstatus_orders
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE l_key_fk_lineitem_orders
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE l_keys_fk_lineitem_orders DYNAMIC ARRAY OF RECORD
        lineitem_orderid LIKE lineitem.orderid,
        lineitem_linenum LIKE lineitem.linenum
    END RECORD
    DEFINE i_fk_lineitem_orders INTEGER
    DEFINE size_fk_lineitem_orders INTEGER

    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.orders_pk_orders_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.orders_pk_orders_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_orders_pk_orders_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_orderstatus_orders
            LET l_sqlQuery = "SELECT orderid, linenum FROM orderstatus WHERE orderstatus.orderid = ?"
            TRY
                DECLARE officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_orderstatus_orders CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_orderstatus_orders
                    USING l_data.orderid
                FETCH officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_orderstatus_orders
                    INTO l_key_fk_orderstatus_orders.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_orderstatus_orders
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_lineitem_orders
                LET l_sqlQuery = "SELECT orderid, linenum FROM lineitem WHERE lineitem.orderid = ?"
                TRY
                    DECLARE officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_lineitem_orders CURSOR FROM l_sqlQuery
                    FOREACH officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_lineitem_orders
                        USING l_data.orderid
                        INTO l_key_fk_lineitem_orders.*
                        LET size_fk_lineitem_orders = size_fk_lineitem_orders + 1
                        LET l_keys_fk_lineitem_orders[size_fk_lineitem_orders].* = l_key_fk_lineitem_orders.*
                    END FOREACH
                    FREE officestore_dbxdata_orders_pk_orders_deleteReferencingRowsByKey_fk_lineitem_orders
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF errNo == ERROR_SUCCESS THEN
                    FOR i_fk_lineitem_orders = 1 TO size_fk_lineitem_orders
                        LET errNo = officestore_dbxdata_lineitem_pk_lineitem_deleteRowByKey(l_keys_fk_lineitem_orders[i_fk_lineitem_orders].*)
                        IF errNo != ERROR_SUCCESS THEN
                            EXIT FOR
                        END IF
                    END FOR
                END IF

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.orders_pk_orders_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_deleteReferencingRowsByKey

{<BLOCK Name="fct.orders_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_orders_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE orders.*
    {<POINT Name="fct.orders_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.orders_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.orders_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.lineitem_pk_lineitem_selectRowByKey">}
#+ Select a row identified by the primary key in the "lineitem" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE lineitem.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE lineitem.*
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE lineitem.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.lineitem_pk_lineitem_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM lineitem
                WHERE lineitem.orderid = p_key.lineitem_orderid
                    AND lineitem.linenum = p_key.lineitem_linenum
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM lineitem
                WHERE lineitem.orderid = p_key.lineitem_orderid
                AND lineitem.linenum = p_key.lineitem_linenum
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.lineitem_pk_lineitem_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_selectRowByKey

{<BLOCK Name="fct.lineitem_insertRowByKey">}
#+ Insert a row in the "lineitem" table and return the primary key created
#+
#+ @param p_data - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER, STRING, INTEGER, INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, lineitem.orderid, lineitem.linenum
PRIVATE FUNCTION officestore_dbxdata_lineitem_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE lineitem.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.lineitem_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.lineitem_insertRowByKey.init" Status="MODIFIED">}
        --Automatically calculates the number of the line
        -- SQLite does not support the FOR UPDATE close in SELECT syntax
        IF p_data.linenum IS NULL THEN
            IF (UPSHIFT(fgl_db_driver_type()) != "SQT") THEN
                SELECT MAX(linenum) + 1 INTO p_data.linenum FROM lineitem WHERE orderid = p_data.orderid FOR UPDATE
            ELSE
                SELECT MAX(linenum) + 1 INTO p_data.linenum FROM lineitem WHERE orderid = p_data.orderid
            END IF
        END IF
        {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_lineitem_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.lineitem_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO lineitem VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.lineitem_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.orderid, p_data.linenum
END FUNCTION
{</BLOCK>} --fct.lineitem_insertRowByKey

{<BLOCK Name="fct.lineitem_pk_lineitem_insertRowByKey">}
#+ Insert a row in the "lineitem" table and return the table keys
#+
#+ @param p_data - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER, STRING, INTEGER, INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, lineitem.orderid, lineitem.linenum
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE lineitem.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.lineitem_pk_lineitem_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.lineitem_pk_lineitem_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_lineitem_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.orderid, p_data.linenum
    RETURN errNo, errMsg, p_data.orderid, p_data.linenum
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_insertRowByKey

{<BLOCK Name="fct.lineitem_pk_lineitem_updateRowByKey">}
#+ Update a row identified by the primary key in the "lineitem" table
#+
#+ @param p_dataT0 - a row data LIKE lineitem.*
#+ @param p_dataT1 - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE lineitem.*
    DEFINE p_dataT1 RECORD LIKE lineitem.*
    DEFINE l_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.lineitem_pk_lineitem_updateRowByKey.define">} {</POINT>}
    LET l_key.lineitem_orderid = p_dataT0.orderid
    LET l_key.lineitem_linenum = p_dataT0.linenum
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.lineitem_pk_lineitem_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.lineitem_pk_lineitem_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_lineitem_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.lineitem_pk_lineitem_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE lineitem
                        SET lineitem.* = p_dataT1.*
                        WHERE lineitem.orderid = l_key.lineitem_orderid
                        AND lineitem.linenum = l_key.lineitem_linenum
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.lineitem_pk_lineitem_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_updateRowByKey

{<BLOCK Name="fct.lineitem_pk_lineitem_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "lineitem" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKey.init">} {</POINT>}
        TRY
            DELETE FROM lineitem
                WHERE lineitem.orderid = p_key.lineitem_orderid
                AND lineitem.linenum = p_key.lineitem_linenum
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_deleteRowByKey

{<BLOCK Name="fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "lineitem" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE lineitem.*
    DEFINE l_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.lineitem_orderid = p_dataT0.orderid
    LET l_key.lineitem_linenum = p_dataT0.linenum
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_lineitem_pk_lineitem_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "lineitem" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE lineitem.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE lineitem.*
    DEFINE l_dataT2 RECORD LIKE lineitem.*
    DEFINE l_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.lineitem_orderid = p_dataT0.orderid
    LET l_key.lineitem_linenum = p_dataT0.linenum
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_lineitem_pk_lineitem_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.lineitem_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_lineitem_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE lineitem.*
    {<POINT Name="fct.lineitem_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.lineitem_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.lineitem_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.item_pk_item_selectRowByKey">}
#+ Select a row identified by the primary key in the "item" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE item.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE item.*
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE item.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.item_pk_item_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.item_pk_item_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM item
                WHERE item.itemid = p_key.item_itemid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM item
                WHERE item.itemid = p_key.item_itemid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.item_pk_item_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.item_pk_item_selectRowByKey

{<BLOCK Name="fct.item_insertRowByKey">}
#+ Insert a row in the "item" table and return the primary key created
#+
#+ @param p_data - a row data LIKE item.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, item.itemid
PRIVATE FUNCTION officestore_dbxdata_item_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE item.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.item_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.item_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_item_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.item_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO item VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.item_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.itemid
END FUNCTION
{</BLOCK>} --fct.item_insertRowByKey

{<BLOCK Name="fct.item_pk_item_insertRowByKey">}
#+ Insert a row in the "item" table and return the table keys
#+
#+ @param p_data - a row data LIKE item.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, item.itemid
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE item.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.item_pk_item_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.item_pk_item_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_item_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.itemid
    RETURN errNo, errMsg, p_data.itemid
END FUNCTION
{</BLOCK>} --fct.item_pk_item_insertRowByKey

{<BLOCK Name="fct.item_pk_item_updateRowByKey">}
#+ Update a row identified by the primary key in the "item" table
#+
#+ @param p_dataT0 - a row data LIKE item.*
#+ @param p_dataT1 - a row data LIKE item.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE item.*
    DEFINE p_dataT1 RECORD LIKE item.*
    DEFINE l_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.item_pk_item_updateRowByKey.define">} {</POINT>}
    LET l_key.item_itemid = p_dataT0.itemid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.item_pk_item_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_item_pk_item_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.item_pk_item_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_item_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.item_pk_item_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE item
                        SET item.* = p_dataT1.*
                        WHERE item.itemid = l_key.item_itemid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.item_pk_item_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_pk_item_updateRowByKey

{<BLOCK Name="fct.item_pk_item_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "item" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.item_pk_item_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.item_pk_item_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM item
                    WHERE item.itemid = p_key.item_itemid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.item_pk_item_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.item_pk_item_deleteRowByKey

{<BLOCK Name="fct.item_pk_item_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "item" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE item.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE item.*
    DEFINE l_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.item_pk_item_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.item_itemid = p_dataT0.itemid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.item_pk_item_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_item_pk_item_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.item_pk_item_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_item_pk_item_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.item_pk_item_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.item_pk_item_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.item_pk_item_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "item" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE item.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE item.*
    DEFINE l_dataT2 RECORD LIKE item.*
    DEFINE l_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.item_pk_item_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.item_itemid = p_dataT0.itemid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.item_pk_item_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_item_pk_item_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.item_pk_item_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.item_pk_item_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.item_pk_item_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.item_pk_item_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "item" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE l_data RECORD LIKE item.*
    DEFINE l_key_fk_lineitem_item
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE l_key_fk_inventory_item
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.item_pk_item_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.item_pk_item_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_item_pk_item_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_lineitem_item
            LET l_sqlQuery = "SELECT orderid, linenum FROM lineitem WHERE lineitem.itemid = ?"
            TRY
                DECLARE officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_lineitem_item CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_lineitem_item
                    USING l_data.itemid
                FETCH officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_lineitem_item
                    INTO l_key_fk_lineitem_item.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_lineitem_item
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_inventory_item
                LET l_sqlQuery = "SELECT itemid FROM inventory WHERE inventory.itemid = ?"
                TRY
                    DECLARE officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_inventory_item CURSOR FROM l_sqlQuery
                    OPEN officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_inventory_item
                        USING l_data.itemid
                    FETCH officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_inventory_item
                        INTO l_key_fk_inventory_item.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE officestore_dbxdata_item_pk_item_deleteReferencingRowsByKey_fk_inventory_item
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.item_pk_item_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.item_pk_item_deleteReferencingRowsByKey

{<BLOCK Name="fct.item_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_item_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE item.*
    {<POINT Name="fct.item_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.item_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.item_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.inventory_pk_inventory_selectRowByKey">}
#+ Select a row identified by the primary key in the "inventory" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE inventory.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE inventory.*
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE inventory.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.inventory_pk_inventory_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.inventory_pk_inventory_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM inventory
                WHERE inventory.itemid = p_key.inventory_itemid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM inventory
                WHERE inventory.itemid = p_key.inventory_itemid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.inventory_pk_inventory_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_selectRowByKey

{<BLOCK Name="fct.inventory_insertRowByKey">}
#+ Insert a row in the "inventory" table and return the primary key created
#+
#+ @param p_data - a row data LIKE inventory.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, inventory.itemid
PRIVATE FUNCTION officestore_dbxdata_inventory_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE inventory.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.inventory_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.inventory_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_inventory_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.inventory_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO inventory VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.inventory_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.itemid
END FUNCTION
{</BLOCK>} --fct.inventory_insertRowByKey

{<BLOCK Name="fct.inventory_pk_inventory_insertRowByKey">}
#+ Insert a row in the "inventory" table and return the table keys
#+
#+ @param p_data - a row data LIKE inventory.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, inventory.itemid
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE inventory.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.inventory_pk_inventory_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.inventory_pk_inventory_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_inventory_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.itemid
    RETURN errNo, errMsg, p_data.itemid
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_insertRowByKey

{<BLOCK Name="fct.inventory_pk_inventory_updateRowByKey">}
#+ Update a row identified by the primary key in the "inventory" table
#+
#+ @param p_dataT0 - a row data LIKE inventory.*
#+ @param p_dataT1 - a row data LIKE inventory.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE inventory.*
    DEFINE p_dataT1 RECORD LIKE inventory.*
    DEFINE l_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.inventory_pk_inventory_updateRowByKey.define">} {</POINT>}
    LET l_key.inventory_itemid = p_dataT0.itemid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.inventory_pk_inventory_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_inventory_pk_inventory_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.inventory_pk_inventory_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_inventory_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.inventory_pk_inventory_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE inventory
                        SET inventory.* = p_dataT1.*
                        WHERE inventory.itemid = l_key.inventory_itemid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.inventory_pk_inventory_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_updateRowByKey

{<BLOCK Name="fct.inventory_pk_inventory_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "inventory" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.inventory_pk_inventory_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.inventory_pk_inventory_deleteRowByKey.init">} {</POINT>}
        TRY
            DELETE FROM inventory
                WHERE inventory.itemid = p_key.inventory_itemid
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.inventory_pk_inventory_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_deleteRowByKey

{<BLOCK Name="fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "inventory" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE inventory.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE inventory.*
    DEFINE l_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.inventory_itemid = p_dataT0.itemid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_inventory_pk_inventory_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_inventory_pk_inventory_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "inventory" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE inventory.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_inventory_pk_inventory_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE inventory.*
    DEFINE l_dataT2 RECORD LIKE inventory.*
    DEFINE l_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.inventory_itemid = p_dataT0.itemid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_inventory_pk_inventory_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.inventory_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_inventory_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE inventory.*
    {<POINT Name="fct.inventory_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.inventory_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.inventory_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.country_pk_country_selectRowByKey">}
#+ Select a row identified by the primary key in the "country" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE country.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE country.*
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE country.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_pk_country_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.country_pk_country_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM country
                WHERE country.code = p_key.country_code
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM country
                WHERE country.code = p_key.country_code
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.country_pk_country_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.country_pk_country_selectRowByKey

{<BLOCK Name="fct.country_insertRowByKey">}
#+ Insert a row in the "country" table and return the primary key created
#+
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING, CHAR(3)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, country.code
PRIVATE FUNCTION officestore_dbxdata_country_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_country_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.country_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO country VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.country_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.code
END FUNCTION
{</BLOCK>} --fct.country_insertRowByKey

{<BLOCK Name="fct.country_pk_country_insertRowByKey">}
#+ Insert a row in the "country" table and return the table keys
#+
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING, CHAR(3)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, country.code
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_pk_country_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.country_pk_country_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_country_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.code
    RETURN errNo, errMsg, p_data.code
END FUNCTION
{</BLOCK>} --fct.country_pk_country_insertRowByKey

{<BLOCK Name="fct.country_pk_country_updateRowByKey">}
#+ Update a row identified by the primary key in the "country" table
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+ @param p_dataT1 - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE p_dataT1 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_pk_country_updateRowByKey.define">} {</POINT>}
    LET l_key.country_code = p_dataT0.code
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_pk_country_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_country_pk_country_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.country_pk_country_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_country_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.country_pk_country_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE country
                        SET country.* = p_dataT1.*
                        WHERE country.code = l_key.country_code
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.country_pk_country_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_pk_country_updateRowByKey

{<BLOCK Name="fct.country_pk_country_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "country" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_pk_country_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_pk_country_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM country
                    WHERE country.code = p_key.country_code
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.country_pk_country_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_pk_country_deleteRowByKey

{<BLOCK Name="fct.country_pk_country_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "country" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_pk_country_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.country_code = p_dataT0.code
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_pk_country_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_country_pk_country_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.country_pk_country_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_country_pk_country_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.country_pk_country_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_pk_country_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.country_pk_country_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "country" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE l_dataT2 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.country_pk_country_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.country_code = p_dataT0.code
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.country_pk_country_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_country_pk_country_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.country_pk_country_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.country_pk_country_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_pk_country_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.country_pk_country_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "country" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE l_data RECORD LIKE country.*
    DEFINE l_key_fk_orders_country_b
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_key_fk_orders_country_s
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_key_fk_account_country
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.country_pk_country_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.country_pk_country_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_country_pk_country_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_orders_country_b
            LET l_sqlQuery = "SELECT orderid FROM orders WHERE orders.billcountry = ?"
            TRY
                DECLARE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_b CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_b
                    USING l_data.code
                FETCH officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_b
                    INTO l_key_fk_orders_country_b.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_b
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_orders_country_s
                LET l_sqlQuery = "SELECT orderid FROM orders WHERE orders.shipcountry = ?"
                TRY
                    DECLARE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_s CURSOR FROM l_sqlQuery
                    OPEN officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_s
                        USING l_data.code
                    FETCH officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_s
                        INTO l_key_fk_orders_country_s.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_orders_country_s
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_account_country
                LET l_sqlQuery = "SELECT userid FROM account WHERE account.country = ?"
                TRY
                    DECLARE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_account_country CURSOR FROM l_sqlQuery
                    OPEN officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_account_country
                        USING l_data.code
                    FETCH officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_account_country
                        INTO l_key_fk_account_country.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE officestore_dbxdata_country_pk_country_deleteReferencingRowsByKey_fk_account_country
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.country_pk_country_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_pk_country_deleteReferencingRowsByKey

{<BLOCK Name="fct.country_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_country_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE country.*
    {<POINT Name="fct.country_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.country_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.country_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.category_pk_category_selectRowByKey">}
#+ Select a row identified by the primary key in the "category" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE category.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE category.*
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE category.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.category_pk_category_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.category_pk_category_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM category
                WHERE category.catid = p_key.category_catid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM category
                WHERE category.catid = p_key.category_catid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.category_pk_category_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.category_pk_category_selectRowByKey

{<BLOCK Name="fct.category_insertRowByKey">}
#+ Insert a row in the "category" table and return the primary key created
#+
#+ @param p_data - a row data LIKE category.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, category.catid
PRIVATE FUNCTION officestore_dbxdata_category_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE category.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.category_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.category_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_category_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.category_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO category VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.category_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.catid
END FUNCTION
{</BLOCK>} --fct.category_insertRowByKey

{<BLOCK Name="fct.category_pk_category_insertRowByKey">}
#+ Insert a row in the "category" table and return the table keys
#+
#+ @param p_data - a row data LIKE category.*
#+
#+ @returnType INTEGER, STRING, CHAR(10)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, category.catid
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE category.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.category_pk_category_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.category_pk_category_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_category_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.catid
    RETURN errNo, errMsg, p_data.catid
END FUNCTION
{</BLOCK>} --fct.category_pk_category_insertRowByKey

{<BLOCK Name="fct.category_pk_category_updateRowByKey">}
#+ Update a row identified by the primary key in the "category" table
#+
#+ @param p_dataT0 - a row data LIKE category.*
#+ @param p_dataT1 - a row data LIKE category.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE category.*
    DEFINE p_dataT1 RECORD LIKE category.*
    DEFINE l_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.category_pk_category_updateRowByKey.define">} {</POINT>}
    LET l_key.category_catid = p_dataT0.catid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.category_pk_category_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_category_pk_category_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.category_pk_category_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_category_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.category_pk_category_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE category
                        SET category.* = p_dataT1.*
                        WHERE category.catid = l_key.category_catid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.category_pk_category_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.category_pk_category_updateRowByKey

{<BLOCK Name="fct.category_pk_category_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "category" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.category_pk_category_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.category_pk_category_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM category
                    WHERE category.catid = p_key.category_catid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.category_pk_category_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.category_pk_category_deleteRowByKey

{<BLOCK Name="fct.category_pk_category_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "category" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE category.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE category.*
    DEFINE l_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.category_pk_category_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.category_catid = p_dataT0.catid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.category_pk_category_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_category_pk_category_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.category_pk_category_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_category_pk_category_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.category_pk_category_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.category_pk_category_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.category_pk_category_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "category" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE category.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE category.*
    DEFINE l_dataT2 RECORD LIKE category.*
    DEFINE l_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.category_pk_category_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.category_catid = p_dataT0.catid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.category_pk_category_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_category_pk_category_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.category_pk_category_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.category_pk_category_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.category_pk_category_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.category_pk_category_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "category" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE l_data RECORD LIKE category.*
    DEFINE l_key_fk_product_category
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE l_key_fk_account_category
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.category_pk_category_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.category_pk_category_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_category_pk_category_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_product_category
            LET l_sqlQuery = "SELECT productid FROM product WHERE product.catid = ?"
            TRY
                DECLARE officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_product_category CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_product_category
                    USING l_data.catid
                FETCH officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_product_category
                    INTO l_key_fk_product_category.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_product_category
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_account_category
                LET l_sqlQuery = "SELECT userid FROM account WHERE account.favcategory = ?"
                TRY
                    DECLARE officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_account_category CURSOR FROM l_sqlQuery
                    OPEN officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_account_category
                        USING l_data.catid
                    FETCH officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_account_category
                        INTO l_key_fk_account_category.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE officestore_dbxdata_category_pk_category_deleteReferencingRowsByKey_fk_account_category
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.category_pk_category_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.category_pk_category_deleteReferencingRowsByKey

{<BLOCK Name="fct.category_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_category_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE category.*
    {<POINT Name="fct.category_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.category_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.category_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.account_pk_account_selectRowByKey">}
#+ Select a row identified by the primary key in the "account" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE account.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE account.*
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE account.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.account_pk_account_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.account_pk_account_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM account
                WHERE account.userid = p_key.account_userid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM account
                WHERE account.userid = p_key.account_userid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.account_pk_account_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.account_pk_account_selectRowByKey

{<BLOCK Name="fct.account_insertRowByKey">}
#+ Insert a row in the "account" table and return the primary key created
#+
#+ @param p_data - a row data LIKE account.*
#+
#+ @returnType INTEGER, STRING, CHAR(80)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, account.userid
PRIVATE FUNCTION officestore_dbxdata_account_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE account.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.account_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.account_insertRowByKey.init">} {</POINT>}
        CALL officestore_dbxconstraints.officestore_dbxconstraints_account_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        {<POINT Name="fct.account_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO account VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            {<POINT Name="fct.account_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.userid
END FUNCTION
{</BLOCK>} --fct.account_insertRowByKey

{<BLOCK Name="fct.account_pk_account_insertRowByKey">}
#+ Insert a row in the "account" table and return the table keys
#+
#+ @param p_data - a row data LIKE account.*
#+
#+ @returnType INTEGER, STRING, CHAR(80)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, account.userid
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE account.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.account_pk_account_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.account_pk_account_insertRowByKey.init">} {</POINT>}

    CALL officestore_dbxdata_account_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.userid
    RETURN errNo, errMsg, p_data.userid
END FUNCTION
{</BLOCK>} --fct.account_pk_account_insertRowByKey

{<BLOCK Name="fct.account_pk_account_updateRowByKey">}
#+ Update a row identified by the primary key in the "account" table
#+
#+ @param p_dataT0 - a row data LIKE account.*
#+ @param p_dataT1 - a row data LIKE account.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE account.*
    DEFINE p_dataT1 RECORD LIKE account.*
    DEFINE l_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.account_pk_account_updateRowByKey.define">} {</POINT>}
    LET l_key.account_userid = p_dataT0.userid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.account_pk_account_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = officestore_dbxdata_account_pk_account_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.account_pk_account_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL officestore_dbxconstraints.officestore_dbxconstraints_account_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.account_pk_account_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                    UPDATE account
                        SET account.* = p_dataT1.*
                        WHERE account.userid = l_key.account_userid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.account_pk_account_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_pk_account_updateRowByKey

{<BLOCK Name="fct.account_pk_account_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "account" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.account_pk_account_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.account_pk_account_deleteRowByKey.init">} {</POINT>}
        TRY
            CALL officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM account
                    WHERE account.userid = p_key.account_userid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        {<POINT Name="fct.account_pk_account_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.account_pk_account_deleteRowByKey

{<BLOCK Name="fct.account_pk_account_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "account" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE account.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE account.*
    DEFINE l_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.account_pk_account_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.account_userid = p_dataT0.userid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.account_pk_account_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = officestore_dbxdata_account_pk_account_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.account_pk_account_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = officestore_dbxdata_account_pk_account_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.account_pk_account_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.account_pk_account_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.account_pk_account_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "account" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE account.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE account.*
    DEFINE l_dataT2 RECORD LIKE account.*
    DEFINE l_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.account_pk_account_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.account_userid = p_dataT0.userid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.account_pk_account_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL officestore_dbxdata_account_pk_account_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.account_pk_account_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.account_pk_account_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.account_pk_account_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.account_pk_account_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "account" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE l_data RECORD LIKE account.*
    DEFINE l_key_fk_signon_account
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE l_keys_fk_signon_account DYNAMIC ARRAY OF RECORD
        signon_userid LIKE signon.userid
    END RECORD
    DEFINE i_fk_signon_account INTEGER
    DEFINE size_fk_signon_account INTEGER
    DEFINE l_key_fk_orders_account
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.account_pk_account_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.account_pk_account_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL officestore_dbxdata_account_pk_account_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key fk_orders_account
            LET l_sqlQuery = "SELECT orderid FROM orders WHERE orders.userid = ?"
            TRY
                DECLARE officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_orders_account CURSOR FROM l_sqlQuery
                OPEN officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_orders_account
                    USING l_data.userid
                FETCH officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_orders_account
                    INTO l_key_fk_orders_account.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_orders_account
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key fk_signon_account
                LET l_sqlQuery = "SELECT userid FROM signon WHERE signon.userid = ?"
                TRY
                    DECLARE officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_signon_account CURSOR FROM l_sqlQuery
                    FOREACH officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_signon_account
                        USING l_data.userid
                        INTO l_key_fk_signon_account.*
                        LET size_fk_signon_account = size_fk_signon_account + 1
                        LET l_keys_fk_signon_account[size_fk_signon_account].* = l_key_fk_signon_account.*
                    END FOREACH
                    FREE officestore_dbxdata_account_pk_account_deleteReferencingRowsByKey_fk_signon_account
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF errNo == ERROR_SUCCESS THEN
                    FOR i_fk_signon_account = 1 TO size_fk_signon_account
                        LET errNo = officestore_dbxdata_signon_pk_signon_deleteRowByKey(l_keys_fk_signon_account[i_fk_signon_account].*)
                        IF errNo != ERROR_SUCCESS THEN
                            EXIT FOR
                        END IF
                    END FOR
                END IF

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.account_pk_account_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.account_pk_account_deleteReferencingRowsByKey

{<BLOCK Name="fct.account_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION officestore_dbxdata_account_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE account.*
    {<POINT Name="fct.account_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.account_setDefaultValuesFromDBSchema.init">} {</POINT>}
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.account_setDefaultValuesFromDBSchema

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
