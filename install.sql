set echo off
spool install.log replace
prompt install log will write to "install.log", please check it after the script run
pause press enter to continue

prompt Are you sure that you are in the noradle-demo project's root directory,
pause if not, break(CTRL-C) and cd it and retry ...
whenever sqlerror exit

--------------------------------------------------------------------------------

prompt Are you sure you have clean empty DEMO db user/schema already?
prompt Noradle demo's units(tables,plsql,...) in oracle will be installed to the schema
prompt You can try the sql scripts below to achieve the preparation required above.
prompt drop user demo cascade;;
prompt create user demo identified by demo default tablespace sysaux temporary tablespace temp;
pause if not, create empty DEMO db users beforehand, and then press enter to continue
accept demodbu char default 'demo' prompt 'Enter the schema/User(must already exist) for noradle demo (demo) : '

prompt Installing Noracle(psp.web) demo app to schema "&demodbu"
pause press enter to continue ...
alter session set current_schema = &demodbu;
@@grant2demo.sql

prompt begin to install Noradle demo schema objects
whenever sqlerror continue
@@demo_data/human_resources/my_main.sql
@@demo_data/url_prefix.sql
whenever sqlerror exit

@@schema/install_demo_obj.sql
exec DBMS_UTILITY.COMPILE_SCHEMA(upper('&demodbu'),false);

whenever sqlerror continue
insert into ext_url_v(key,prefix) values('myself','/f');
commit;
whenever sqlerror exit

prompt noradle-demo bundle in oracle db part have been installed successfully!
prompt Please follow the steps below to learn from demo
prompt 1. config server_config_t, start oracle processes and dispatcher process as in noradle document/wiki
prompt 2. run `noradle-demo [dispatcher_addr:=1522] [http_listen_addr:=8888]`
prompt 3. in your browser, access "http://localhost:8888/demo" (for example) to see the demo
spool off
