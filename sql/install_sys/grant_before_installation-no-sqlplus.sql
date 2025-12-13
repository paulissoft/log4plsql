-------------------------------------------------------------------
--
--  File : grant_before_installation-no-sqlplus.sql (SQL script)
--
--  Description : Administrator file.
--                Grant Oracle packages to the log user.
-------------------------------------------------------------------
--
-- history : who                 created     comment
--     V1    Gert-Jan Paulissen  13-DEC-25   No SQL*Plus
--                                           commands so it can be
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

declare
  l_user all_users.username%type;
  
  procedure execute_immediate(p_statement in varchar2, p_ignore_errors in boolean default false)
  is
  begin
    dbms_output.put_line(p_statement);
    execute immediate p_statement;
  exception
    when others
    then
      if p_ignore_errors
      then
        dbms_output.put_line('ERROR ignored: ' || sqlerrm);
      else
        raise_application_error(-20000, p_statement, true);
      end if;
  end;
begin
  dbms_application_info.read_client_info(l_user); -- for instance set by grant_after_installation.sql
  
  -- allow for mixed case username
  begin
    select  username
    into    l_user
    from    all_users u
    where   u.username in (l_user, lower(l_user), upper(l_user));
  exception
    when others
    then raise_application_error(-20000, 'Could not find user ''' || l_user || '''', true);
  end;
  
  execute_immediate(utl_lms.format_message('GRANT CREATE VIEW TO "%s"', l_user));
  -- grant needed to get SID of current session
  execute_immediate(utl_lms.format_message('GRANT SELECT ON SYS.V_$MYSTAT TO "%s"', l_user));
  -- grant needed to write log messages in alert.log or trace files 
  execute_immediate(utl_lms.format_message('GRANT EXECUTE ON SYS.DBMS_SYSTEM TO "%s"', l_user), true);
  -- following grant needed for the optional output 
  -- in advanded queue (AQ) consumed by the log4j background process 
  execute_immediate(utl_lms.format_message('GRANT EXECUTE ON SYS.DBMS_AQ TO "%s"', l_user));
  execute_immediate(utl_lms.format_message('GRANT EXECUTE ON SYS.DBMS_AQADM TO "%s"', l_user));
  execute_immediate(utl_lms.format_message('GRANT EXECUTE ON SYS.DBMS_AQIN TO "%s"', l_user));
  execute_immediate(utl_lms.format_message('GRANT EXECUTE ON SYS.DBMS_AQJMS TO "%s"', l_user));
end;
/
