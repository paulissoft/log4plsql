-------------------------------------------------------------------
--
--  File : install-no-sqlplus.sql (SQL script)
--
--  Description : Install minimal version of LOG4PLSQL
--                without SQLPLus commands.
--                Can be run by DBMS_CLOUD_REPO.INSTALL_FILE.
-------------------------------------------------------------------
--
-- history : who                 created     comment
--     V1    Gert-Jan Paulissen  13-DEC-25   Creation
--
-------------------------------------------------------------------
/*
 * Copyright (C) LOG4PLSQL project team. All rights reserved.
 *
 * This software is published under the terms of the The LOG4PLSQL 
 * Software License, a copy of which has been included with this
 * distribution in the LICENSE.txt file.  
 * see: <http://log4plsql.sourceforge.net>  */

-- Uncommenting the next two --/* and --*/ lines
-- allows you to run it from a SQL client like SQL Developer
-- and stop on any error.

/*
whenever oserror exit failure
whenever sqlerror exit failure
*/

-- minimal installation without SQL*Plus commands so it can be used by DBMS_CLOUD_REPO.INSTALL_FILE
@@create_table_tloglevel.sql
@@insert_into_tloglevel.sql
@@create_table_tlog.sql
@@create_sequence_sq_stg.sql
@@create_type_logmessage.sql
@@ps_plogparam.sql
@@pb_plogparam.sql
@@ps_plog_out_tlog.sql
@@pb_plog_out_tlog.sql
@@ps_plog_interface.sql
-- Create dynamically the package body PLOG_INTERFACE ...
@@pb_plog_interface.sql
@@ps_plog.sql
@@pb_plog.sql
@@create_view_vlog.sql
