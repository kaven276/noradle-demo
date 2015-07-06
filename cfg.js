/**
 * Created by cuccpkfs on 14-12-17.
 */

module.exports = {
  http_port: parseInt(process.argv[3] || 8080),
  oracle_addr: (process.argv[2] || '').split(':'),
  oracle_keep_alive: 60,
  demo_dbu: 'demo1',
  static_url: '/',
  static_root: __dirname + '/static',
  upload_dir: __dirname + '/upload'
}