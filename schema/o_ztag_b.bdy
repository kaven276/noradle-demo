create or replace package body o_ztag_b is

	procedure d is 
	begin
		r.setc('l$', '/static/');
		r.setc('l$jquery.js', '//cdn.bootcss.com/jquery/2.1.4/jquery.min.js');
		r.setc('l$bootstrap.css', '//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css');
	
		b.l('<!DOCTYPE html>');
		o.t('<html>');
		o.t('<head>');
		o.u(' <base target=_blank/>', '^js/test.js');
		o.u(' <script>', '[jquery.js]', '');
		o.u(' <link rel=stylesheet/>', '[bootstrap.css]');
		o.t('</head>');
		o.t('<body>');
	
		o.t('<script type=text>');
		o.u(' <frame>', './pack_b.proc', '');
		o.u(' <iframe>', './pack_b.proc', '');
		o.t('</script>');
	
		o.u('<a target=window1 title=linktest>', './pack_b.proc', 'inner text');
		o.u('<a>', './pack_b.proc');
		x.t(' wrapped text');
		o.u(' <img/>', '^img/banner.jpg');
		o.t('</a>');
	
		o.u('<form name=f1 method=post>', '@c.d');
		o.v(' <input name=n1 type=text/>', 'value1');
		o.v(' <input name=n2 type=checkbox/>', 'o1', true);
		o.v(' <input name=n2 type=checkbox/>', 'o2', false);
		o.v(' <input name=n2 type=checkbox/>', 'o3');
		o.t(' <label>', o.v('<input name=r type=radio/>', 'r1') || 'item1');
		o.t(' <label>', o.v('<input name=r type=radio/>', 'r2', true) || 'item2');
		o.t(' <label>', o.v('<input name=r type=radio/>', 'r3', false) || 'item3');
		o.t(' <select multiple name=n3>');
		o.v('  <option>', 'v1', 'text1');
		o.v('  <option>', 'v2', 'text2', true);
		o.v('  <option>', 'v3', 'text3', false);
		o.t(' </select>');
		o.t('</form>');
	
		tmp.p(1) := t.tf(false);
		tmp.p(2) := t.tf(false);
		tmp.p(3) := 'info';
		tmp.p(4) := 'appended';
		o.t('<div#container?.bg-info?.alert.alert-?.prefix+?>', 'inner text');
	
		tmp.p(1) := t.tf(false);
		tmp.p(2) := t.tf(false);
		tmp.p(3) := t.tf(true);
		tmp.p(4) := 'flag-pass';
		tmp.p(5) := 'defer';
		o.t('<div checked? readonly disabled? -ok? -? ?>', 'inner text');
	
		tmp.p(1) := '600';
		tmp.p(2) := 'click:func1';
		o.t('  <div width=400 height=? style="border:1px solid red;" -bind=?>');
		o.t('  </div>');
		o.t($$plsql_unit);
		o.t($$plsql_line);
		o.c('comment');
		o.d($$plsql_unit, $$plsql_line);
		o.t('</body>');
		o.t('</html>');
	end;

end o_ztag_b;
/
