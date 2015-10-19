#!/usr/bin/env node
/**
 * Created by cuccpkfs on 14-12-17.
 */
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

var http = require('http')
  , noradle = require('noradle')
  , harp = require('harp')
  , express = require('express')
  , app = express()
  , http_port = parseInt(process.argv[3] || 8888)
  , dispatcher_addr = (process.argv[2] || '1522').split(':')
  , y$static = '/demo/'
  , dbPool = noradle.DBDriver.connect(dispatcher_addr, {
    cid : 'demo',
    passwd : 'demo'
  })
  ;

// set url routes
function set_route(){

  app.use(noradle.handlerHTTP(dbPool, {
    url_pattern : '/x$app/x$prog',
    x$dbu : 'demo',
    x$prog : 'index_b.frame',
    u$location : '/demo/',
    y$static : y$static,
    favicon_url : y$static + 'favicon.ico',
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

  app.use(y$static, harp.mount(__dirname + '/static'));

}

/**
 * start a combined http server, which inlucde
 * plsql servlet, static file, harp compiler
 */
http.createServer(app).listen(http_port, function(){
  console.log('http server is listening at ' + http_port);
});
set_route();
