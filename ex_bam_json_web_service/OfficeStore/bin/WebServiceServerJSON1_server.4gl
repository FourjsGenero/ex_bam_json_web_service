{<CODEFILE Path="WebServiceServerJSON1.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ JSON Web service server program

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
IMPORT FGL libdbappWS

IMPORT FGL Customers_service

{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Functions
#+ Web Service Server. Starts the engine.
#+
MAIN
    DEFINE ret INTEGER
    DEFINE timeOut INTEGER
    DEFINE maximumResponseLength INTEGER

    DEFINE comHttpRequest com.HttpServiceRequest
    DEFINE dbappHttpRequest libdbappWS.restHttpServiceRequest

    DEFINE dbappHttpResponse libdbappWS.restHttpResponse
    {<POINT Name="MAIN.define">} {</POINT>}

    LET timeOut = -1 --infinite waiting time
    LET maximumResponseLength = -1 --no size limit
    {<POINT Name="MAIN.init">} {</POINT>}

    CALL com.WebServiceEngine.SetOption("maximumresponselength",maximumResponseLength)
    {<POINT Name="MAIN.webEngineOptions">} {</POINT>}

    --Connect to the database.
    DISPLAY "Connecting to the database..."
    CONNECT TO "officestore"
    DISPLAY "Connected to the 'officestore' database."

    --Start the Web Server.
    DISPLAY "Starting the server..."
    CALL com.WebServiceEngine.Start()
    DISPLAY "The Server is started"
    DISPLAY "The server is listening..."

    LET INT_FLAG = 0
    CALL libdbappWS.initializeRestHttpResponse() RETURNING dbappHttpResponse.*

    WHILE TRUE
        TRY
            --Process each incoming requests (infinite loop)
            LET comHttpRequest = com.WebServiceEngine.GetHttpServiceRequest(timeOut)

            --Create an HTTP REST service request.
            CALL libdbappWS.createRestHttpServiceRequest(comHttpRequest) RETURNING dbappHttpRequest.*
            CASE dbappHttpRequest.resources.root
                WHEN "Customers"
                    CALL Customers_service.Customers_service_process(dbappHttpRequest.*) RETURNING dbappHttpResponse.*
                OTHERWISE
                    --Undefined resource
                    LET dbappHttpResponse.statusCode = libdbappWSCore.HTTPStatus_404_code
            END CASE

            --Send the HTTP dbappHttpResponse
            CALL libdbappWS.sendTextResponseRestHttpServiceRequest(comHttpRequest, dbappHttpResponse.*)

            IF INT_FLAG != 0 THEN
                LET INT_FLAG = 0
                EXIT WHILE
            END IF
        CATCH
            LET ret = STATUS
            CASE ret
                WHEN -15565
                    DISPLAY "Disconnected from application server."
                    EXIT WHILE
                OTHERWISE
                    DISPLAY "[ERROR] ", ret
                    EXIT WHILE
            END CASE
        END TRY
    END WHILE

    DISPLAY "Server stopped."
    {<POINT Name="MAIN.finish">} {</POINT>}
END MAIN

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
