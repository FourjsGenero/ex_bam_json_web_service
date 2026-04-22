-- Do not reference this file using 'IMPORT FGL Customers'

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL Customers_common
IMPORT FGL libdbappEvents
# Uncomment the IMPORT FGL you need
#
# IMPORT FGL libdbappExt
# IMPORT FGL libdbappFormUI
# IMPORT FGL libdbappReportCore
# IMPORT FGL libdbappReportUI
# IMPORT FGL libdbappSql
# IMPORT FGL libdbappUI
# IMPORT FGL libdbappWS
# IMPORT FGL libdbappWSClient
# IMPORT FGL libdbappWSCore
# IMPORT FGL officestore_dbxdata

-- Database schema
SCHEMA officestore

-- Declare your PUBLIC module variables here.
PUBLIC DEFINE dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type
