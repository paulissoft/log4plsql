-- uninstall the minimal version of LOG4PLSQL as installed by install-no-sqlplus.sql
declare
  l_current_schema constant all_users.username%type := sys_context('USERENV', 'CURRENT_SCHEMA');
begin
  for r in
  ( select  'DROP ' || o.object_type || ' ' || o.object_name || case when o.object_type = 'TABLE' then ' PURGE' end as statement
    from    all_objects o
    where   o.owner = l_current_schema
    and     o.object_type || '|' || o.object_name in
            ( null
            , 'PACKAGE|PLOG'
            , 'PACKAGE|PLOGPARAM'
            , 'PACKAGE|PLOG_INTERFACE'
            , 'PACKAGE|PLOG_OUT_TLOG'
            , 'SEQUENCE|SQ_STG'
            , 'TABLE|TLOG'
            , 'TABLE|TLOGLEVEL'
            , 'TYPE|LOGMESSAGE'
            , 'VIEW|VLOG'
            )
    order by
            statement
  )
  loop
    execute immediate r.statement;
  end loop;
end;
/
