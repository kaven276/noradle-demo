#!/usr/bin/env node
/**
 * Created by cuccpkfs on 14-12-17.
 */

var program = require('commander');

program
  .version(require('./package.json').version)
  .option('-p, --listen_port [port]', 'listening port', '8888')
  .option('-d, --dispatcher_addr [port:host]', 'dispatcher listening address', '1522:')
  .option('--cid [client id]', 'client identifier to access dispatcher', 'demo')
  .option('--passwd [password]', 'password for cid', 'demo')
  .option('--dbu [database user]', 'database schema user that hold demo objects', 'demo')
  .parse(process.argv)
;

console.log('noradle-demo server started with the following options:');
console.log(require('text-table')('listen_port,dispatcher_addr,cid,passwd,dbu'.split(',').map(function(key, i){
  return [key, program[key]];
})));

var marked = require('marked');
marked.setOptions({
  renderer : new marked.Renderer(),
  gfm : true,
  tables : true,
  breaks : false,
  pedantic : false,
  sanitize : false,
  smartLists : true,
  smartypants : false,
  highlight : function(code){
    return require('highlight.js').highlightAuto(code).value;
  },
  _highlight : function(code, lang, callback){
    require('pygmentize-bundled')({lang : lang, format : 'html'}, code, function(err, result){
      callback(err, result.toString());
    });
  }
});

var noradle = require('noradle')
  , express = require('express')
  , app = express()
  , y$static = '/demo/'
  ;

var dbPool = noradle.DBDriver.connect((program.dispatcher_addr).split(':'), {
  cid : program.cid,
  passwd : program.passwd
});

app.use(noradle.handlerHTTP(dbPool, {
  x$dbu : program.dbu,
  url_pattern : '/i$app/x$prog',
  x$prog : 'index_b.frame',
  u$location : '/demo/',
  l$ : y$static,
  upload_dir : __dirname + '/upload',
  template_dir : __dirname + '/static/template',
  template_engine : 'jade',
  converters : {
    marked : marked
  },
  check_session_hijack : false,
  NoneBrowserPattern : /^$/
}));

app.use(y$static, express.static(__dirname + '/static', {
  maxAge : 24 * 60 * 60,
  redirect : false
}));

app.use('/upload', express.static(__dirname + '/upload', {
  maxAge : 24 * 60 * 60,
  redirect : false
}));

//app.use(y$static, require('harp').mount(__dirname + '/static'));

app.get('/favicon.ico', function(req, res){
  res.redirect(301, y$static + 'favicon.ico');
});

/**
 * start a combined http server, which inclucde
 * plsql servlet, static file, harp compiler
 */

app.listen(program.listen_port, function(){
  console.log('http server is listening at ' + program.listen_port);
});
