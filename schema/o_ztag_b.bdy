create or replace package body o_ztag_b is

	procedure id_classes is
	begin
		src_b.header;
		b.l('tip: code id/classed just as css selector');
		o.t('<div#id.class1.class2.class3>');
	end;

	procedure bool_attr is
	begin
		src_b.header;
		b.l('tip: just write bool attributes with space separator');
		o.t('<div checked readonly disabled>');
	end;

	procedure value_attr is
	begin
		src_b.header;
		b.l('tip: value is not required to wrap with " ", unless it contain space');
		o.t('<div width=600 height=300 style="1px solid red;">');
	end;

	procedure data_attr is
	begin
		src_b.header;
		b.l('tip: html5 data-attr just omit "data", prefix with "-" is enough');
		o.t('<div -toggle=dropdown -bind=click:func1>');
	end;

	procedure tag_all is
	begin
		src_b.header;
		b.l('tip: required order: tag,id, classes, bool attrs, value attrs');
		o.t('<a#id.btn.btn-primary disabled target=_blank -toggle=dropdown style="color:red">', 'inner text');
	end;

	procedure url is
	begin
		src_b.header;
		r.setc('l$', '/static/');
		b.l('tip: some tag have attr that''s url type, just supply it with 2nd param');
	
		o.u('<base target=_blank/>', '^js/test.js');
		o.u('<script>', '[jquery.js]', '');
		o.u('<link rel=stylesheet/>', '[bootstrap.css]');
	
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
		o.t('</form>');
	end;

	procedure val is
	begin
		src_b.header;
		b.l('tip: some tag(input/option) use dynamic value attr and optional checked/selected bool attr');
	
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
	end;

	procedure param is
	begin
		src_b.header;
	
		-- direct use tmp.p(idx)
		tmp.p(1) := t.tf(false);
		tmp.p(2) := t.tf(false);
		tmp.p(3) := 'info';
		tmp.p(4) := 'appended';
		o.t('<div#container?.bg-info?.alert.alert-?.prefix+?>', 'inner text');
	
		-- indirect use o.p(idx, value)
		o.p(1, false);
		o.p(2, false);
		o.p(3, false);
		o.p(4, 'flag-pass');
		o.p(5, 'defer');
		o.t('<div checked? readonly disabled? -ok? -? ?>', 'inner text');
	
		-- from index 6 for params
		tmp.p(6) := '600';
		tmp.p(7) := 'click:func1';
		o.t('  <div width=400 height=? style="border:1px solid red;" -bind=?>6');
		o.t('  </div>');
	end;

	procedure comments is
	begin
		src_b.header;
		b.l('tip: print html comments');
		o.c('comment');
	end;

	procedure trace is
	begin
		src_b.header;
		b.l('tip: trace back to source which plsql unit/line print the current content');
		o.d($$plsql_unit, $$plsql_line);
	end;

	procedure d is
	begin
		src_b.header;
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
