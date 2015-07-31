/**
 * Created by cuccpkfs on 14-12-17.
 */

module.exports = {
  http_port: parseInt(process.argv[3] || 8888),
  dispatcher_addr: (process.argv[2] || '1522').split(':'),
  demo_dbu: 'demo',
  static_url: '/',
  static_root: __dirname + '/static',
  upload_dir: __dirname + '/upload',
  client_auth: {
    cid: 'demo',
    passwd: 'demo'
  }
};