noradle official demo app show how to use http servlet, NDBC, call-out(with socket.io) with oracle PL/SQL.

# install

npm -g install noradle-demo

cd "project root"

sqlplus "/ as sysdba" @install.sql

In oracle database, configure server_control_t, add a record point to listening address of this demo server.

`npm start` or `node ./server.js` to start the demo.

If oracle server for noradle is not started, in noradle core user(PSP), run `exec k_pmon.run_job` to start.

Check http://127.0.0.1:8888/demo to see if demo web app is working.
