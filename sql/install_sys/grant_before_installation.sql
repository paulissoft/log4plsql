-------------------------------------------------------------------
--
--  File : grant_before_installation.sql (SQLPlus script)
--
--  Description : Administrator file.
--                Grant Oracle packages to the log user.
-------------------------------------------------------------------
--
-- history : who                 created     comment
--     V3    Bertrand Caradec    15-MAY-08   Creation
--     V4    Gert-Jan Paulissen  13-DEC-25   Moved part to another 
--                                           script so that can be
--                                           used by
--                                           DBMS_CLOUD_REPO.
--
-------------------------------------------------------------------
/*
 * Copyright (C) LOG4PLSQL project team. All rights reserved.
 *
 * This software is published under the terms of the The LOG4PLSQL 
 * Software License, a copy of which has been included with this
 * distribution in the LICENSE.txt file.  
 * see: <http://log4plsql.sourceforge.net>  */

whenever oserror exit failure
whenever sqlerror exit failure

set serveroutput on

set define on verify off feedback off

ACCEPT V_USER CHAR PROMPT 'Enter the user name:'

-- Store the username so it can be retrieved by grant_before_installation-no-sqlplus.sql.
-- Assumes length of username <= 64 bytes.

begin
  dbms_application_info.set_client_info('&v_user');
end;
/

@@grant_before_installation-no-sqlplus.sql

set verify on feedback on
