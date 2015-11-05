create or replace package body easy_url_b is

	procedure d is
	begin
		src_b.header;
		x.l('<link>', '*.css');
		x.j('<script>', '*.js');
		x.j('<script>', '^packs/url_test1_b/proc.js');
	
		x.p('<p>', 'I''m in a standalone procedure');
		x.p('<p>', 'r.prog=' || r.prog);
		x.p('<p>', 'r.pack=' || r.pack);
		x.p('<p>', 'r.proc=' || r.proc);
		x.p('<p>', 'r.getc(''y$static'')=' || r.getc('y$static'));
		x.t('<hr/>');
	
		x.p('<h3>', '>>> Links to plsql servlet');
		x.p('<p>', x.a('<a>', 'link to my package''s sub procedure in "@x.proc" pattern', '@b.link_transparent'));
		x.p('<p>',
				x.a('<a>', 'link to some package''s sub procedure in "./pack.proc" form', './easy_url_b.link_transparent'));
		x.p('<p>', x.a('<a>', 'link to a standalone procedure in "./proc" pattern', './url_test1_b'));
	
		x.p('<h3>', '>>> Links to static files.');
		x.p('<p>', 'link to my package''s img (CHN.gif)' || x.i('<img>', '@b/CHN.gif'));
		x.p('<p>', 'link to a package''s img (url_b/CHN.gif)' || x.i('<img>', '^packs/easy_url_b/CHN.gif'));
		x.p('<p>', 'link to a procedure''s img (url_test1_b/USA.gif)' || x.i('<img>', '^packs/url_test1_b/USA.gif'));
		x.p('<p>', 'link to file directly under static root (^GER.gif)' || x.i('<img>', '^GER.gif'));
		x.p('<p>', 'link to file under static root subdir (^img/nations/JPN.gif)' || x.i('<img>', '^img/nations/JPN.gif'));
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to other site''s resources');
		x.p('<p>', 'this is outsite''s img ([myself]img/nations/ITA.gif)' || x.i('<img>', '[myself]img/nations/ITA.gif'));
		x.p('<p>',
				'this is for abs path (http://www.oracleimg.com/us/assets/oralogo-small.gif)' ||
				x.i('<img>', 'http://www.oracleimg.com/us/assets/oralogo-small.gif'));
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to other url schemas');
		x.p('<p>', x.a('<a>', 'link to javascript', 'javascript:alert(''link to javascript'')'));
	
		x.c('</body>');
		x.c('</html>');
	end;

	procedure link_transparent is
	begin
		src_b.header;
		x.p('<p>',
				x.a('<a>',
						'transparently(untouched) link to url without any particular prefix symbol in "=@*^\"',
						'ora_good_b.entry'));
		x.p('<p>', x.a('<a>', 'back', 'javascript:history.back();'));
	end;

	procedure link_equal_to is
	begin
		src_b.header;
		x.p('<p>', x.a('<a>', 'link to url with "=" prefix', '=ora_good_b.entry'));
	end;

	procedure link_proc_in_same_pack is
	begin
		src_b.header;
		x.p('<p>', 'prefix "@" will be replaced by package name "x$pack" with last suffix character trimmed');
		x.a('<a>', 'link to procedure in the same package using "@x.xxx" pattern', '@b.link_transparent');
	end;

	procedure link_proc_in_any_pack is
	begin
		src_b.header;
		x.a('<a>', 'link to procedure in any other package directly', 'ora_good_b.entry');
	end;

	procedure link_standalone_proc is
	begin
		src_b.header;
		x.a('<a>', 'link to standalone procedure directly', 'url_test1_b');
	end;

	procedure link_static_for_site is
	begin
		src_b.header;
		x.p('<p>', 'prefix "^" will be replaced by r.getc(y$static)');
		x.p('<p>', '"^path/file.ext" will expand to "{y$static}path/file.ext"');
		x.p('<p>', 'y$static=' || r.get('y$static', './'));
		x.i('<img>', '^GER.gif');
		x.i('<img>', '^img/nations/USA.gif');
	end;

	procedure link_static_for_pack is
	begin
		src_b.header;
		x.p('<p>', 'prefix "@" will be replaced by package name "x$pack" with last suffix character trimmed');
		x.p('<p>', '"@x/file" indicate static file reference belong to this package/procedure only');
		x.p('<p>', '"@x/file" will expand to "{y$static}/packs/{x$pack?}/file"');
		x.p('<p>', 'y$static=' || r.get('y$static', './'));
		x.p('<p>', 'x$pack=' || r.get('x$pack', './'));
		x.i('<img>', '@b/CHN.gif');
	end;

	procedure link_static_for_me is
	begin
		--x.l('<link type=image/gif>', '*.gif', 'icon');
		x.l('<link type=image/x-icon>', '*.ico', 'icon');
		src_b.header;
		x.p('<p>', 'prefix * will be replaced by "{x$pack}/{x$proc}"');
		x.p('<p>', '"*.suffix" indicate static file reference belong to this package, and named this procedure only');
		x.p('<p>', '"*.suffix" will expand to "{y$static}packs/{x$pack}/{x$proc}.suffix"');
		x.p('<p>', 'y$static=' || r.get('y$static', './'));
		x.p('<p>', 'x$pack=' || r.get('x$pack', './'));
		x.p('<p>', 'x$proc=' || r.get('x$proc', './'));
		x.i('<img>', '*.gif');
		x.l('<link>', '*.css');
		x.j('<script>', '*.js');
	end;

	procedure link_other_parallel_app_static is
	begin
		src_b.header;
		x.p('<p>', 'sometimes, we need to refer to other parallel static app''s url that provide common static files');
		x.a('<a>', 'link to "{y$static}../some_other_app/path_to_file.ext" ', '^../demo1/img/larry.jpg');
	end;

	procedure link_configured_url is
	begin
		src_b.header;
		r.setc('[bootstrap]', l('^bower_lib/bootstrap/dist'));
		x.l('<link>', '[bootstrap]/css/bootstrap.min.css');
		x.j('<script>', '[jquery]');
		--x.j('<script>', '[bootstrap]/js/bootstrap.min.js');
		x.p('<p>', 'see ' || x.a('<a>', 'k_filter.before', 'src_b.proc?p=k_filter.before') || ' for url prefix setting');
		x.p('<p>', 'url like "[key]subpath", "[key]" will be replaced with value in view "ext_url_v" ');
		x.p('<p>', 'or preset with r.setc([key],url_prefix), it have higher priority than ext_url_v config');
		x.p('<p>', 'the following demo use boostrap css UI');
		x.a('<a#tar.btn.btn-primary>', 'noradle url link document', '[url_link_doc]');
		x.p('<script>', '$("#tar").fadeOut().fadeIn()');
	end;

	procedure use_base_url_for_static is
	begin
		src_b.header;
		--x.s('<base href=:1>', st(l('^')));
		--x.b('<base>','^');
		x.b('<base>');
		x.p('<p>', 'base url set to static foot url');
		x.p('<p>', 'reference servlet by ./pack.proc or @x.proc pattern for relative path');
		x.p('<p>', x.a('<a>', 'link to static(image)', 'img/larry.jpg'));
		x.p('<p>', x.a('<a>', 'link to servlet(to self)', './easy_url_b.use_base_url_for_static'));
		x.p('<p>', x.a('<a>', 'link to servlet(to self)', '@b.use_base_url_for_static'));
	end;

	procedure param_use_stv is
	begin
		src_b.header;
		x.p('<p>', 'current url is :' || r.url);
		x.p('<p>', 'note: one line for param values, one line for url param filling, one line use url');
		tmp.stv := st('v1', 'v2', 'v3');
		tmp.url := t.ps('@b.param_use_stv?p1=:1&p2=:2&p3=:3');
		x.p('<p>', x.a('<a>', 'link params filled with tmp.stv', tmp.url));
	end;

	procedure param_interpolate is
	begin
		src_b.header;
		x.p('<p>', 'current url is :' || r.url);
		x.p('<p>', 'note: url tailed with "@" will trigger interpolation');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(as req)', '@b.param_interpolate?{p1}&{p2}@'));
		r.del('p1');
		r.del('p2');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(not exists)', '@b.param_interpolate?{p1}&{p2}@'));
		r.setc('p1', 'v1');
		r.setc('p2', 'v2');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(exists)', '@b.param_interpolate?{p1}&{p2}@'));
	end;

	procedure param_use_vqstr is
	begin
		src_b.header;
		r.setc('p3', 'v3');
		x.p('<p>', 'current url is :' || r.url);
		x.p('<p>', q'|note: your can append r.vqstr value to a url prefix|');
		x.p('<p>', 'r.vqstr: ' || r.vqstr);
		x.p('<p>', q'!r.vqstr('p1,p3'): !' || r.vqstr('p1,p3'));
		x.p('<p>', x.a('<a>', 'link to me with 5 params', r.prog || '?p1=v1&p2=v2'));
	end;

	procedure param_tail is
	begin
		src_b.header;
		x.p('<p>', 'current url is :' || r.url);
		x.p('<p>', 'note: url suffixed with "?" or "&" denote uncomplete url that will be appended with r.getc(l$?)');
		x.p('<p>', x.a('<a>', 'link to url lack of tail (as req)', '@b.param_tail?'));
		r.del('l$?');
		x.p('<p>', x.a('<a>', 'link to url lack of tail (no tail)', '@b.param_tail?'));
		r.setc('l$?', 'flag=Y');
		x.p('<p>', x.a('<a>', 'link to url lack of tail (has tail)', '@b.param_tail?'));
	end;

	procedure param_interpolate_tail is
	begin
		src_b.header;
		x.p('<p>', 'current url is :' || r.url);
		x.p('<p>', 'note: interpolation and tail completion can co-exist, suffix like "?@" or "&@"');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(as req)', '@b.param_interpolate_tail?{p1}&@'));
		r.del('p1');
		r.del('l$?');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(not exists)', '@b.param_interpolate_tail?{p1}&@'));
		r.setc('p1', 'v1');
		r.setc('l$?', 'flag=Y');
		x.p('<p>', x.a('<a>', 'link to url interpolated with NV env(exists)', '@b.param_interpolate_tail?{p1}&@'));
	end;

end easy_url_b;
/
