{<CODEFILE Path="officestore.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ DB schema - Constraints Management (officestore)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp4.1
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA officestore

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.supplier_checkTableConstraints">}
#+ Check constraints on the "supplier" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE supplier.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_supplier_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE supplier.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.supplier_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.supplier_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_supplier_suppid_checkColumnConstraints(p_data.suppid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_supplier_sustatus_checkColumnConstraints(p_data.sustatus) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_supplier_pk_supplier_checkUniqueConstraint(p_forUpdate, p_data.suppid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.supplier_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_checkTableConstraints

{<BLOCK Name="fct.supplier_pk_supplier_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "supplier"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_supplier_pk_supplier_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE l_key
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.supplier_pk_supplier_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE supplier.suppid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), suppid FROM supplier ", l_where, " GROUP BY suppid"
    {<POINT Name="fct.supplier_pk_supplier_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_supplier_pk_supplier_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_supplier_pk_supplier_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_supplier_pk_supplier_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Supplier Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.supplier_pk_supplier_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_checkUniqueConstraint

{<BLOCK Name="fct.supplier_suppid_checkColumnConstraints">}
#+ Check constraints on the "supplier.suppid" column
#+
#+ @param p_suppid - SERIAL - Supplier Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_supplier_suppid_checkColumnConstraints(p_suppid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_suppid LIKE supplier.suppid
    {<POINT Name="fct.supplier_suppid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.supplier_suppid_checkColumnConstraints.init">} {</POINT>}
    IF p_suppid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- suppid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.supplier_suppid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_suppid_checkColumnConstraints

{<BLOCK Name="fct.supplier_sustatus_checkColumnConstraints">}
#+ Check constraints on the "supplier.sustatus" column
#+
#+ @param p_sustatus - CHAR(2) - Status
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_supplier_sustatus_checkColumnConstraints(p_sustatus)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sustatus LIKE supplier.sustatus
    {<POINT Name="fct.supplier_sustatus_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.supplier_sustatus_checkColumnConstraints.init">} {</POINT>}
    IF p_sustatus IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sustatus: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.supplier_sustatus_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_sustatus_checkColumnConstraints

{<BLOCK Name="fct.supplier_pk_supplier_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "supplier"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_supplier_pk_supplier_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            supplier_suppid LIKE supplier.suppid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.supplier_pk_supplier_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.supplier_suppid IS NULL) THEN
        LET l_where = "WHERE supplier.suppid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM supplier ", l_where
        {<POINT Name="fct.supplier_pk_supplier_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_supplier_pk_supplier_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_supplier_pk_supplier_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_supplier_pk_supplier_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Supplier Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.supplier_pk_supplier_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.supplier_pk_supplier_checkFKConstraint

{<BLOCK Name="fct.signon_checkTableConstraints">}
#+ Check constraints on the "signon" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE signon.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_signon_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE signon.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.signon_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.signon_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_signon_userid_checkColumnConstraints(p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_signon_password_checkColumnConstraints(p_data.password) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_signon_pk_signon_checkUniqueConstraint(p_forUpdate, p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_account_pk_account_checkFKConstraint(p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.signon_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_checkTableConstraints

{<BLOCK Name="fct.signon_pk_signon_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "signon"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_signon_pk_signon_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE l_key
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.signon_pk_signon_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE signon.userid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), userid FROM signon ", l_where, " GROUP BY userid"
    {<POINT Name="fct.signon_pk_signon_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_signon_pk_signon_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_signon_pk_signon_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_signon_pk_signon_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- User Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.signon_pk_signon_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_checkUniqueConstraint

{<BLOCK Name="fct.signon_userid_checkColumnConstraints">}
#+ Check constraints on the "signon.userid" column
#+
#+ @param p_userid - CHAR(80) - User Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_signon_userid_checkColumnConstraints(p_userid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_userid LIKE signon.userid
    {<POINT Name="fct.signon_userid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.signon_userid_checkColumnConstraints.init">} {</POINT>}
    IF p_userid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- userid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.signon_userid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_userid_checkColumnConstraints

{<BLOCK Name="fct.signon_password_checkColumnConstraints">}
#+ Check constraints on the "signon.password" column
#+
#+ @param p_password - CHAR(25) - Password
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_signon_password_checkColumnConstraints(p_password)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_password LIKE signon.password
    {<POINT Name="fct.signon_password_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.signon_password_checkColumnConstraints.init">} {</POINT>}
    IF p_password IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- password: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.signon_password_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_password_checkColumnConstraints

{<BLOCK Name="fct.signon_pk_signon_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "signon"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_signon_pk_signon_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            signon_userid LIKE signon.userid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.signon_pk_signon_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.signon_userid IS NULL) THEN
        LET l_where = "WHERE signon.userid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM signon ", l_where
        {<POINT Name="fct.signon_pk_signon_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_signon_pk_signon_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_signon_pk_signon_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_signon_pk_signon_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- User Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.signon_pk_signon_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.signon_pk_signon_checkFKConstraint

{<BLOCK Name="fct.seqreg_checkTableConstraints">}
#+ Check constraints on the "seqreg" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_seqreg_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.seqreg_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_seqreg_sr_name_checkColumnConstraints(p_data.sr_name) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_seqreg_sr_last_checkColumnConstraints(p_data.sr_last) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_seqreg_pk_seqreg_checkUniqueConstraint(p_forUpdate, p_data.sr_name) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.seqreg_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_checkTableConstraints

{<BLOCK Name="fct.seqreg_pk_seqreg_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "seqreg"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_seqreg_pk_seqreg_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE seqreg.sr_name = ? "
    LET l_sqlQuery = "SELECT COUNT(*), sr_name FROM seqreg ", l_where, " GROUP BY sr_name"
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_seqreg_pk_seqreg_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_seqreg_pk_seqreg_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_seqreg_pk_seqreg_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Table Name: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkUniqueConstraint

{<BLOCK Name="fct.seqreg_sr_name_checkColumnConstraints">}
#+ Check constraints on the "seqreg.sr_name" column
#+
#+ @param p_sr_name - VARCHAR(30) - Table Name
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_seqreg_sr_name_checkColumnConstraints(p_sr_name)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sr_name LIKE seqreg.sr_name
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.init">} {</POINT>}
    IF p_sr_name IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_name: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_sr_name_checkColumnConstraints

{<BLOCK Name="fct.seqreg_sr_last_checkColumnConstraints">}
#+ Check constraints on the "seqreg.sr_last" column
#+
#+ @param p_sr_last - INTEGER - Last Serial
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_seqreg_sr_last_checkColumnConstraints(p_sr_last)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sr_last LIKE seqreg.sr_last
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.init">} {</POINT>}
    IF p_sr_last IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_last: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_sr_last_checkColumnConstraints

{<BLOCK Name="fct.seqreg_pk_seqreg_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "seqreg"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_seqreg_pk_seqreg_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.seqreg_sr_name IS NULL) THEN
        LET l_where = "WHERE seqreg.sr_name = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM seqreg ", l_where
        {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_seqreg_pk_seqreg_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_seqreg_pk_seqreg_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_seqreg_pk_seqreg_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Table Name: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkFKConstraint

{<BLOCK Name="fct.product_checkTableConstraints">}
#+ Check constraints on the "product" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE product.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_product_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE product.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.product_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.product_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_product_productid_checkColumnConstraints(p_data.productid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_product_catid_checkColumnConstraints(p_data.catid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_product_pk_product_checkUniqueConstraint(p_forUpdate, p_data.productid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_category_pk_category_checkFKConstraint(p_data.catid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.product_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_checkTableConstraints

{<BLOCK Name="fct.product_pk_product_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "product"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_product_pk_product_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE l_key
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.product_pk_product_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE product.productid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), productid FROM product ", l_where, " GROUP BY productid"
    {<POINT Name="fct.product_pk_product_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_product_pk_product_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_product_pk_product_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_product_pk_product_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Product Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.product_pk_product_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_pk_product_checkUniqueConstraint

{<BLOCK Name="fct.product_productid_checkColumnConstraints">}
#+ Check constraints on the "product.productid" column
#+
#+ @param p_productid - CHAR(10) - Product Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_product_productid_checkColumnConstraints(p_productid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_productid LIKE product.productid
    {<POINT Name="fct.product_productid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.product_productid_checkColumnConstraints.init">} {</POINT>}
    IF p_productid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- productid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.product_productid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_productid_checkColumnConstraints

{<BLOCK Name="fct.product_catid_checkColumnConstraints">}
#+ Check constraints on the "product.catid" column
#+
#+ @param p_catid - CHAR(10) - Category Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_product_catid_checkColumnConstraints(p_catid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_catid LIKE product.catid
    {<POINT Name="fct.product_catid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.product_catid_checkColumnConstraints.init">} {</POINT>}
    IF p_catid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- catid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.product_catid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_catid_checkColumnConstraints

{<BLOCK Name="fct.product_pk_product_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "product"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_product_pk_product_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            product_productid LIKE product.productid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.product_pk_product_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.product_productid IS NULL) THEN
        LET l_where = "WHERE product.productid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM product ", l_where
        {<POINT Name="fct.product_pk_product_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_product_pk_product_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_product_pk_product_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_product_pk_product_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Product Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.product_pk_product_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.product_pk_product_checkFKConstraint

{<BLOCK Name="fct.orderstatus_checkTableConstraints">}
#+ Check constraints on the "orderstatus" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE orderstatus.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE orderstatus.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.orderstatus_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orderstatus_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_orderstatus_orderid_checkColumnConstraints(p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orderstatus_linenum_checkColumnConstraints(p_data.linenum) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orderstatus_mdate_checkColumnConstraints(p_data.mdate) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orderstatus_orstatus_checkColumnConstraints(p_data.orstatus) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_orderstatus_pk_orderstatus_checkUniqueConstraint(p_forUpdate, p_data.orderid, p_data.linenum) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_orders_pk_orders_checkFKConstraint(p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.orderstatus_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_checkTableConstraints

{<BLOCK Name="fct.orderstatus_pk_orderstatus_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "orderstatus"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_pk_orderstatus_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE l_key
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE orderstatus.orderid = ?",
                    " AND orderstatus.linenum = ? "
    LET l_sqlQuery = "SELECT COUNT(*), orderid, linenum FROM orderstatus ", l_where, " GROUP BY orderid, linenum"
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_orderstatus_pk_orderstatus_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_orderstatus_pk_orderstatus_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_orderstatus_pk_orderstatus_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order Id + #Line: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_checkUniqueConstraint

{<BLOCK Name="fct.orderstatus_orderid_checkColumnConstraints">}
#+ Check constraints on the "orderstatus.orderid" column
#+
#+ @param p_orderid - INTEGER - Order Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_orderid_checkColumnConstraints(p_orderid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_orderid LIKE orderstatus.orderid
    {<POINT Name="fct.orderstatus_orderid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orderstatus_orderid_checkColumnConstraints.init">} {</POINT>}
    IF p_orderid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- orderid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orderstatus_orderid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_orderid_checkColumnConstraints

{<BLOCK Name="fct.orderstatus_linenum_checkColumnConstraints">}
#+ Check constraints on the "orderstatus.linenum" column
#+
#+ @param p_linenum - INTEGER - #Line
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_linenum_checkColumnConstraints(p_linenum)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_linenum LIKE orderstatus.linenum
    {<POINT Name="fct.orderstatus_linenum_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orderstatus_linenum_checkColumnConstraints.init">} {</POINT>}
    IF p_linenum IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- linenum: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orderstatus_linenum_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_linenum_checkColumnConstraints

{<BLOCK Name="fct.orderstatus_mdate_checkColumnConstraints">}
#+ Check constraints on the "orderstatus.mdate" column
#+
#+ @param p_mdate - DATE - Modification date
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_mdate_checkColumnConstraints(p_mdate)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_mdate LIKE orderstatus.mdate
    {<POINT Name="fct.orderstatus_mdate_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orderstatus_mdate_checkColumnConstraints.init">} {</POINT>}
    IF p_mdate IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- mdate: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orderstatus_mdate_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_mdate_checkColumnConstraints

{<BLOCK Name="fct.orderstatus_orstatus_checkColumnConstraints">}
#+ Check constraints on the "orderstatus.orstatus" column
#+
#+ @param p_orstatus - CHAR(2) - Status
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_orstatus_checkColumnConstraints(p_orstatus)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_orstatus LIKE orderstatus.orstatus
    {<POINT Name="fct.orderstatus_orstatus_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orderstatus_orstatus_checkColumnConstraints.init">} {</POINT>}
    IF p_orstatus IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- orstatus: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orderstatus_orstatus_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_orstatus_checkColumnConstraints

{<BLOCK Name="fct.orderstatus_pk_orderstatus_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "orderstatus"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orderstatus_pk_orderstatus_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            orderstatus_orderid LIKE orderstatus.orderid,
            orderstatus_linenum LIKE orderstatus.linenum
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.orderstatus_orderid IS NULL AND p_data.orderstatus_linenum IS NULL) THEN
        LET l_where = "WHERE orderstatus.orderid = ?",
                    " AND orderstatus.linenum = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM orderstatus ", l_where
        {<POINT Name="fct.orderstatus_pk_orderstatus_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_orderstatus_pk_orderstatus_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_orderstatus_pk_orderstatus_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_orderstatus_pk_orderstatus_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order Id + #Line: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.orderstatus_pk_orderstatus_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orderstatus_pk_orderstatus_checkFKConstraint

{<BLOCK Name="fct.orders_checkTableConstraints">}
#+ Check constraints on the "orders" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE orders.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE orders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.orders_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_orders_orderid_checkColumnConstraints(p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orders_userid_checkColumnConstraints(p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orders_orderdate_checkColumnConstraints(p_data.orderdate) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orders_totalprice_checkColumnConstraints(p_data.totalprice) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orders_sourceapp_checkColumnConstraints(p_data.sourceapp) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_orders_pk_orders_checkUniqueConstraint(p_forUpdate, p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_account_pk_account_checkFKConstraint(p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_country_pk_country_checkFKConstraint(p_data.billcountry) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_country_pk_country_checkFKConstraint(p_data.shipcountry) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.orders_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_checkTableConstraints

{<BLOCK Name="fct.orders_pk_orders_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "orders"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_pk_orders_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_key
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.orders_pk_orders_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE orders.orderid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), orderid FROM orders ", l_where, " GROUP BY orderid"
    {<POINT Name="fct.orders_pk_orders_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_orders_pk_orders_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_orders_pk_orders_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_orders_pk_orders_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order No: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.orders_pk_orders_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_checkUniqueConstraint

{<BLOCK Name="fct.orders_orderid_checkColumnConstraints">}
#+ Check constraints on the "orders.orderid" column
#+
#+ @param p_orderid - SERIAL - Order No
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_orderid_checkColumnConstraints(p_orderid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_orderid LIKE orders.orderid
    {<POINT Name="fct.orders_orderid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_orderid_checkColumnConstraints.init">} {</POINT>}
    IF p_orderid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- orderid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orders_orderid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_orderid_checkColumnConstraints

{<BLOCK Name="fct.orders_userid_checkColumnConstraints">}
#+ Check constraints on the "orders.userid" column
#+
#+ @param p_userid - CHAR(80) - User Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_userid_checkColumnConstraints(p_userid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_userid LIKE orders.userid
    {<POINT Name="fct.orders_userid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_userid_checkColumnConstraints.init">} {</POINT>}
    IF p_userid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- userid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orders_userid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_userid_checkColumnConstraints

{<BLOCK Name="fct.orders_orderdate_checkColumnConstraints">}
#+ Check constraints on the "orders.orderdate" column
#+
#+ @param p_orderdate - DATE - Order Date
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_orderdate_checkColumnConstraints(p_orderdate)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_orderdate LIKE orders.orderdate
    {<POINT Name="fct.orders_orderdate_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_orderdate_checkColumnConstraints.init">} {</POINT>}
    IF p_orderdate IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- orderdate: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orders_orderdate_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_orderdate_checkColumnConstraints

{<BLOCK Name="fct.orders_totalprice_checkColumnConstraints">}
#+ Check constraints on the "orders.totalprice" column
#+
#+ @param p_totalprice - DECIMAL(10,2) - Total Price
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_totalprice_checkColumnConstraints(p_totalprice)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_totalprice LIKE orders.totalprice
    {<POINT Name="fct.orders_totalprice_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_totalprice_checkColumnConstraints.init">} {</POINT>}
    IF p_totalprice IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- totalprice: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orders_totalprice_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_totalprice_checkColumnConstraints

{<BLOCK Name="fct.orders_sourceapp_checkColumnConstraints">}
#+ Check constraints on the "orders.sourceapp" column
#+
#+ @param p_sourceapp - CHAR(3) - Origin Application
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_sourceapp_checkColumnConstraints(p_sourceapp)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sourceapp LIKE orders.sourceapp
    {<POINT Name="fct.orders_sourceapp_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.orders_sourceapp_checkColumnConstraints.init">} {</POINT>}
    IF p_sourceapp IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sourceapp: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.orders_sourceapp_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_sourceapp_checkColumnConstraints

{<BLOCK Name="fct.orders_pk_orders_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "orders"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_orders_pk_orders_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            orders_orderid LIKE orders.orderid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.orders_pk_orders_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.orders_orderid IS NULL) THEN
        LET l_where = "WHERE orders.orderid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM orders ", l_where
        {<POINT Name="fct.orders_pk_orders_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_orders_pk_orders_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_orders_pk_orders_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_orders_pk_orders_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order No: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.orders_pk_orders_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.orders_pk_orders_checkFKConstraint

{<BLOCK Name="fct.lineitem_checkTableConstraints">}
#+ Check constraints on the "lineitem" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE lineitem.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE lineitem.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.lineitem_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_lineitem_orderid_checkColumnConstraints(p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_lineitem_linenum_checkColumnConstraints(p_data.linenum) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_lineitem_itemid_checkColumnConstraints(p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_lineitem_quantity_checkColumnConstraints(p_data.quantity) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_lineitem_unitprice_checkColumnConstraints(p_data.unitprice) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_lineitem_pk_lineitem_checkUniqueConstraint(p_forUpdate, p_data.orderid, p_data.linenum) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_item_pk_item_checkFKConstraint(p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_orders_pk_orders_checkFKConstraint(p_data.orderid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.lineitem_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_checkTableConstraints

{<BLOCK Name="fct.lineitem_pk_lineitem_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "lineitem"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_pk_lineitem_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE l_key
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE lineitem.orderid = ?",
                    " AND lineitem.linenum = ? "
    LET l_sqlQuery = "SELECT COUNT(*), orderid, linenum FROM lineitem ", l_where, " GROUP BY orderid, linenum"
    {<POINT Name="fct.lineitem_pk_lineitem_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_lineitem_pk_lineitem_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_lineitem_pk_lineitem_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_lineitem_pk_lineitem_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order Id + #Line: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.lineitem_pk_lineitem_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_checkUniqueConstraint

{<BLOCK Name="fct.lineitem_orderid_checkColumnConstraints">}
#+ Check constraints on the "lineitem.orderid" column
#+
#+ @param p_orderid - INTEGER - Order Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_orderid_checkColumnConstraints(p_orderid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_orderid LIKE lineitem.orderid
    {<POINT Name="fct.lineitem_orderid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_orderid_checkColumnConstraints.init">} {</POINT>}
    IF p_orderid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- orderid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.lineitem_orderid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_orderid_checkColumnConstraints

{<BLOCK Name="fct.lineitem_linenum_checkColumnConstraints">}
#+ Check constraints on the "lineitem.linenum" column
#+
#+ @param p_linenum - INTEGER - #Line
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_linenum_checkColumnConstraints(p_linenum)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_linenum LIKE lineitem.linenum
    {<POINT Name="fct.lineitem_linenum_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_linenum_checkColumnConstraints.init">} {</POINT>}
    IF p_linenum IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- linenum: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.lineitem_linenum_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_linenum_checkColumnConstraints

{<BLOCK Name="fct.lineitem_itemid_checkColumnConstraints">}
#+ Check constraints on the "lineitem.itemid" column
#+
#+ @param p_itemid - CHAR(10) - Item Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_itemid_checkColumnConstraints(p_itemid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_itemid LIKE lineitem.itemid
    {<POINT Name="fct.lineitem_itemid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_itemid_checkColumnConstraints.init">} {</POINT>}
    IF p_itemid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- itemid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.lineitem_itemid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_itemid_checkColumnConstraints

{<BLOCK Name="fct.lineitem_quantity_checkColumnConstraints">}
#+ Check constraints on the "lineitem.quantity" column
#+
#+ @param p_quantity - INTEGER - Quantity
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_quantity_checkColumnConstraints(p_quantity)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_quantity LIKE lineitem.quantity
    {<POINT Name="fct.lineitem_quantity_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_quantity_checkColumnConstraints.init">} {</POINT>}
    IF p_quantity IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- quantity: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.lineitem_quantity_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_quantity_checkColumnConstraints

{<BLOCK Name="fct.lineitem_unitprice_checkColumnConstraints">}
#+ Check constraints on the "lineitem.unitprice" column
#+
#+ @param p_unitprice - DECIMAL(10,2) - Unit Price
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_unitprice_checkColumnConstraints(p_unitprice)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_unitprice LIKE lineitem.unitprice
    {<POINT Name="fct.lineitem_unitprice_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.lineitem_unitprice_checkColumnConstraints.init">} {</POINT>}
    IF p_unitprice IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- unitprice: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.lineitem_unitprice_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_unitprice_checkColumnConstraints

{<BLOCK Name="fct.lineitem_pk_lineitem_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "lineitem"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_lineitem_pk_lineitem_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            lineitem_orderid LIKE lineitem.orderid,
            lineitem_linenum LIKE lineitem.linenum
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.lineitem_pk_lineitem_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.lineitem_orderid IS NULL AND p_data.lineitem_linenum IS NULL) THEN
        LET l_where = "WHERE lineitem.orderid = ?",
                    " AND lineitem.linenum = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM lineitem ", l_where
        {<POINT Name="fct.lineitem_pk_lineitem_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_lineitem_pk_lineitem_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_lineitem_pk_lineitem_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_lineitem_pk_lineitem_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Order Id + #Line: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.lineitem_pk_lineitem_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.lineitem_pk_lineitem_checkFKConstraint

{<BLOCK Name="fct.item_checkTableConstraints">}
#+ Check constraints on the "item" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE item.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_item_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE item.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.item_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.item_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_item_itemid_checkColumnConstraints(p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_item_productid_checkColumnConstraints(p_data.productid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_item_pk_item_checkUniqueConstraint(p_forUpdate, p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_product_pk_product_checkFKConstraint(p_data.productid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_supplier_pk_supplier_checkFKConstraint(p_data.supplier) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.item_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_checkTableConstraints

{<BLOCK Name="fct.item_pk_item_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "item"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_item_pk_item_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE l_key
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.item_pk_item_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE item.itemid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), itemid FROM item ", l_where, " GROUP BY itemid"
    {<POINT Name="fct.item_pk_item_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_item_pk_item_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_item_pk_item_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_item_pk_item_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Item Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.item_pk_item_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_pk_item_checkUniqueConstraint

{<BLOCK Name="fct.item_itemid_checkColumnConstraints">}
#+ Check constraints on the "item.itemid" column
#+
#+ @param p_itemid - CHAR(10) - Item Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_item_itemid_checkColumnConstraints(p_itemid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_itemid LIKE item.itemid
    {<POINT Name="fct.item_itemid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.item_itemid_checkColumnConstraints.init">} {</POINT>}
    IF p_itemid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- itemid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.item_itemid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_itemid_checkColumnConstraints

{<BLOCK Name="fct.item_productid_checkColumnConstraints">}
#+ Check constraints on the "item.productid" column
#+
#+ @param p_productid - CHAR(10) - Product Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_item_productid_checkColumnConstraints(p_productid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_productid LIKE item.productid
    {<POINT Name="fct.item_productid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.item_productid_checkColumnConstraints.init">} {</POINT>}
    IF p_productid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- productid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.item_productid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_productid_checkColumnConstraints

{<BLOCK Name="fct.item_pk_item_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "item"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_item_pk_item_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            item_itemid LIKE item.itemid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.item_pk_item_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.item_itemid IS NULL) THEN
        LET l_where = "WHERE item.itemid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM item ", l_where
        {<POINT Name="fct.item_pk_item_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_item_pk_item_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_item_pk_item_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_item_pk_item_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Item Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.item_pk_item_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.item_pk_item_checkFKConstraint

{<BLOCK Name="fct.inventory_checkTableConstraints">}
#+ Check constraints on the "inventory" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE inventory.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_inventory_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE inventory.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.inventory_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.inventory_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_inventory_itemid_checkColumnConstraints(p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_inventory_qty_checkColumnConstraints(p_data.qty) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_inventory_pk_inventory_checkUniqueConstraint(p_forUpdate, p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_item_pk_item_checkFKConstraint(p_data.itemid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.inventory_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_checkTableConstraints

{<BLOCK Name="fct.inventory_pk_inventory_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "inventory"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_inventory_pk_inventory_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE l_key
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.inventory_pk_inventory_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE inventory.itemid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), itemid FROM inventory ", l_where, " GROUP BY itemid"
    {<POINT Name="fct.inventory_pk_inventory_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_inventory_pk_inventory_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_inventory_pk_inventory_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_inventory_pk_inventory_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Item Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.inventory_pk_inventory_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_checkUniqueConstraint

{<BLOCK Name="fct.inventory_itemid_checkColumnConstraints">}
#+ Check constraints on the "inventory.itemid" column
#+
#+ @param p_itemid - CHAR(10) - Item Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_inventory_itemid_checkColumnConstraints(p_itemid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_itemid LIKE inventory.itemid
    {<POINT Name="fct.inventory_itemid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.inventory_itemid_checkColumnConstraints.init">} {</POINT>}
    IF p_itemid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- itemid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.inventory_itemid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_itemid_checkColumnConstraints

{<BLOCK Name="fct.inventory_qty_checkColumnConstraints">}
#+ Check constraints on the "inventory.qty" column
#+
#+ @param p_qty - INTEGER - Stock quantity
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_inventory_qty_checkColumnConstraints(p_qty)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_qty LIKE inventory.qty
    {<POINT Name="fct.inventory_qty_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.inventory_qty_checkColumnConstraints.init">} {</POINT>}
    IF p_qty IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- qty: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.inventory_qty_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_qty_checkColumnConstraints

{<BLOCK Name="fct.inventory_pk_inventory_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "inventory"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_inventory_pk_inventory_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            inventory_itemid LIKE inventory.itemid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.inventory_pk_inventory_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.inventory_itemid IS NULL) THEN
        LET l_where = "WHERE inventory.itemid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM inventory ", l_where
        {<POINT Name="fct.inventory_pk_inventory_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_inventory_pk_inventory_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_inventory_pk_inventory_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_inventory_pk_inventory_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Item Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.inventory_pk_inventory_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.inventory_pk_inventory_checkFKConstraint

{<BLOCK Name="fct.country_checkTableConstraints">}
#+ Check constraints on the "country" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_country_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.country_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.country_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_country_code_checkColumnConstraints(p_data.code) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_country_pk_country_checkUniqueConstraint(p_forUpdate, p_data.code) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.country_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_checkTableConstraints

{<BLOCK Name="fct.country_pk_country_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "country"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_country_pk_country_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE l_key
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.country_pk_country_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE country.code = ? "
    LET l_sqlQuery = "SELECT COUNT(*), code FROM country ", l_where, " GROUP BY code"
    {<POINT Name="fct.country_pk_country_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_country_pk_country_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_country_pk_country_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_country_pk_country_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Country code: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.country_pk_country_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_pk_country_checkUniqueConstraint

{<BLOCK Name="fct.country_code_checkColumnConstraints">}
#+ Check constraints on the "country.code" column
#+
#+ @param p_code - CHAR(3) - Country code
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_country_code_checkColumnConstraints(p_code)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_code LIKE country.code
    {<POINT Name="fct.country_code_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.country_code_checkColumnConstraints.init">} {</POINT>}
    IF p_code IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- code: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.country_code_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_code_checkColumnConstraints

{<BLOCK Name="fct.country_pk_country_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "country"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_country_pk_country_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            country_code LIKE country.code
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.country_pk_country_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.country_code IS NULL) THEN
        LET l_where = "WHERE country.code = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM country ", l_where
        {<POINT Name="fct.country_pk_country_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_country_pk_country_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_country_pk_country_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_country_pk_country_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Country code: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.country_pk_country_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_pk_country_checkFKConstraint

{<BLOCK Name="fct.category_checkTableConstraints">}
#+ Check constraints on the "category" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE category.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_category_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE category.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.category_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.category_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_category_catid_checkColumnConstraints(p_data.catid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_category_pk_category_checkUniqueConstraint(p_forUpdate, p_data.catid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.category_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.category_checkTableConstraints

{<BLOCK Name="fct.category_pk_category_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "category"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_category_pk_category_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE l_key
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.category_pk_category_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE category.catid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), catid FROM category ", l_where, " GROUP BY catid"
    {<POINT Name="fct.category_pk_category_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_category_pk_category_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_category_pk_category_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_category_pk_category_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Category Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.category_pk_category_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.category_pk_category_checkUniqueConstraint

{<BLOCK Name="fct.category_catid_checkColumnConstraints">}
#+ Check constraints on the "category.catid" column
#+
#+ @param p_catid - CHAR(10) - Category Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_category_catid_checkColumnConstraints(p_catid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_catid LIKE category.catid
    {<POINT Name="fct.category_catid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.category_catid_checkColumnConstraints.init">} {</POINT>}
    IF p_catid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- catid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.category_catid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.category_catid_checkColumnConstraints

{<BLOCK Name="fct.category_pk_category_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "category"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_category_pk_category_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            category_catid LIKE category.catid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.category_pk_category_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.category_catid IS NULL) THEN
        LET l_where = "WHERE category.catid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM category ", l_where
        {<POINT Name="fct.category_pk_category_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_category_pk_category_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_category_pk_category_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_category_pk_category_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- Category Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.category_pk_category_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.category_pk_category_checkFKConstraint

{<BLOCK Name="fct.account_checkTableConstraints">}
#+ Check constraints on the "account" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE account.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE account.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.account_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.account_checkTableConstraints.init">} {</POINT>}

    CALL officestore_dbxconstraints_account_userid_checkColumnConstraints(p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_account_firstname_checkColumnConstraints(p_data.firstname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_account_lastname_checkColumnConstraints(p_data.lastname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_account_pk_account_checkUniqueConstraint(p_forUpdate, p_data.userid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL officestore_dbxconstraints_category_pk_category_checkFKConstraint(p_data.favcategory) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL officestore_dbxconstraints_country_pk_country_checkFKConstraint(p_data.country) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.account_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_checkTableConstraints

{<BLOCK Name="fct.account_pk_account_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "account"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_pk_account_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE l_key
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.account_pk_account_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE account.userid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), userid FROM account ", l_where, " GROUP BY userid"
    {<POINT Name="fct.account_pk_account_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_account_pk_account_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_account_pk_account_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_account_pk_account_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- User Id: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.account_pk_account_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_pk_account_checkUniqueConstraint

{<BLOCK Name="fct.account_userid_checkColumnConstraints">}
#+ Check constraints on the "account.userid" column
#+
#+ @param p_userid - CHAR(80) - User Id
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_userid_checkColumnConstraints(p_userid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_userid LIKE account.userid
    {<POINT Name="fct.account_userid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.account_userid_checkColumnConstraints.init">} {</POINT>}
    IF p_userid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- userid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.account_userid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_userid_checkColumnConstraints

{<BLOCK Name="fct.account_firstname_checkColumnConstraints">}
#+ Check constraints on the "account.firstname" column
#+
#+ @param p_firstname - CHAR(80) - First Name
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_firstname_checkColumnConstraints(p_firstname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_firstname LIKE account.firstname
    {<POINT Name="fct.account_firstname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.account_firstname_checkColumnConstraints.init">} {</POINT>}
    IF p_firstname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- firstname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.account_firstname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_firstname_checkColumnConstraints

{<BLOCK Name="fct.account_lastname_checkColumnConstraints">}
#+ Check constraints on the "account.lastname" column
#+
#+ @param p_lastname - CHAR(80) - Last Name
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_lastname_checkColumnConstraints(p_lastname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_lastname LIKE account.lastname
    {<POINT Name="fct.account_lastname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.account_lastname_checkColumnConstraints.init">} {</POINT>}
    IF p_lastname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- lastname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.account_lastname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_lastname_checkColumnConstraints

{<BLOCK Name="fct.account_pk_account_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "account"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION officestore_dbxconstraints_account_pk_account_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            account_userid LIKE account.userid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.account_pk_account_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.account_userid IS NULL) THEN
        LET l_where = "WHERE account.userid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM account ", l_where
        {<POINT Name="fct.account_pk_account_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_account_pk_account_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_account_pk_account_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_account_pk_account_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- User Id: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.account_pk_account_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.account_pk_account_checkFKConstraint

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
