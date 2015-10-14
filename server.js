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

var cfg = require('./cfg.js')
  , http = require('http')
  , noradle = require('noradle')
  , harp = require('harp')
  , express = require('express')
  , app = express()
  , port = cfg.http_port
  , y$static = cfg.static_url + cfg.demo_dbu + '/'
  , dbPool = noradle.DBDriver.connect(cfg.dispatcher_addr, cfg.client_auth)
  ;

function ReqBaseC(req){
  this.y$static = y$static;
}

function adjust_env(rb, req){
  if (rb.x$dbu === '') {
    rb.x$dbu = cfg.demo_dbu;
    rb.location = '/demo/';
  } else if (rb.x$dbu === 'demo') {
    rb.x$dbu = cfg.demo_dbu;
  }
}

// set url routes
function set_route(){

  app.use(y$static, express.static(cfg.static_root, {
    maxAge : cfg.oneDay,
    redirect : false
  }));

  app.use(y$static, harp.mount(cfg.static_root));

  app.use(noradle.handlerHTTP(dbPool, ReqBaseC, {
    check_session_hijack : false,
    NoneBrowserPattern : /^$/,
    static_url : cfg.static_url,
    upload_dir : cfg.upload_dir,
    template_dir : cfg.template_dir,
    template_engine : cfg.template_engine,
    favicon_url : y$static + 'favicon.ico',
    adjust_env_func : adjust_env,
    converters : {
      marked : marked
    }
  }));

}

/**
 * start a combined http server, which inlucde
 * plsql servlet, static file, harp compiler
 */
http.createServer(app).listen(port, function(){
  console.log('http server is listening at ' + port);
});
set_route();
