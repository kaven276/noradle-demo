noradle official demo app show how to use http servlet, NDBC, call-out(with socket.io) with oracle PL/SQL.

# introduction

  "noradle-demo" is originally a part from "[noradle](https://github.com/kaven276/noradle)" project as "./demo" sub directory,
now, the demo app in [noradle](https://www.npmjs.com/package/noradle) is a independent project.

# install

npm -g install noradle-demo

cd "project root"

sqlplus "/ as sysdba" @install.sql

or

sqlplus "/ as sysdba" @http://static.noradle.com/repo/noradle-demo/install.sql

In oracle database, configure server_control_t, and run noradle dispatcher to listen for client connection.

`npm start [dispatcher_addr:=1522] [http_listen_addr:=8888]` to start the demo.

or

run `noradle-demo [dispatcher_addr:=1522] [http_listen_addr:=8888]`

how to start noradle server, see <https://github.com/kaven276/noradle>

Check http://127.0.0.1:8888/demo to see if demo web app is working.

# feature exhibited

* get http request info
  - for basic http header
  - for cookie values
  - for querystring
  - for form post
  - get varchar2, number, date parameters
  - for file upload
  - for post entity body

* write response info
  - basic h.line, h.write API
  - x. TAG print API
  - m. interpolate template with comma separated string, array or sys_refcursor
  - tb. support table print
  - tr. support tree structure print, usually ul,li nested tags
  - use l(url) to easy specify url the plsql servlet link to
  - rs. print sys_refcursor data as compact sql result set that can be easy parsed to javascript objects
  - multiple ways of print xml data
  - demos that easy utilize css frameworks like bootstrap, pure-css, jquery-mobile
  - embed/link coupled-in css
  - auto redirect post to *_c* procedure to a feedback page
  - clean previous output in buffer, and regenerating page response

* charset and international support
  - support db-charset output or any unicode output, auto conversion
  - content negotiation for accept-language

* set response headers that affect the process afterward
  - chunked transfer with `h.flush`, return partial response as quick as possible
  - long job that must give partial reponse to client after one step is completed
  - response compression like gzip
  - response body conversion for *text/items* and *text/resultsets*
  - specify *Content-Type*
  - specify charset
  - file download or attachement
  - http redirect immediately or after a delay

* filter support
  - before filter used for authentication check, cache data prefetch
  - after filter for logging
  - login & logoff

* session
  - get session data
  - set session data

* oracle result-cache
  - utilize oracle result cache to cache frequent access data like filter data fetch
  - force cache invalidate or update when time is out or then real data is changed

* use NDBC call
  - set default parameters
  - call with parameters
  - use response callback that receive statis,header,entity
  - if automatic convert original response from oracle to javascript object
  - support *text/items*, that is lines of data, save line separator is used
  - support "text/resultsets*, that is produced from sys_refcursor

* execute call out from oracle (repeated NDBC call)
  - call plsql servlet that wait event like pipe new message
  - after plsql servlet wait event timeout, repeat call the plsql servlet
  - call for oracle call-out message, and send back response to oracle calling service
  - use h.begin_msg,h.end_msg to mark output to header/body is for call-out message
