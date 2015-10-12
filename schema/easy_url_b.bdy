create or replace package body easy_url_b is

	procedure d is
	begin
		x.o('<html>');
		x.o('<head>');
		x.l(' <link>', '*.css');
		x.j(' <script>', '*.js');
		x.j(' <script>', '^packs/url_test1_b/proc.js');
		x.o(' <style>');
		x.t('  a{display:block;line-height:1.5em;}');
		x.t('  p{margin:0.2em;}');
		x.t('  li{margin:0.5em;line-height:1.2em;}');
		x.c(' </style>');
		x.c('</head>');
		x.o('<body>');
	
		src_b.link_proc;
		x.p('<p>', 'r.prog=' || r.prog);
		x.p('<p>', 'r.pack=' || r.pack);
		x.p('<p>', 'r.proc=' || r.proc);
	
		x.p('<h3>', 'URL reference test suite includes the following items');
		x.o('<ol>');
		x.p(' <li>',
				'pack1.proc1-> pack1.proc2 : (other_proc) <br/>
				a packaged proc include another proc in the same package');
		x.p(' <li>',
				'pack1.procn-> pack2.procm : (other_proc_x, other_pack_x.other_proc) <br/>
				a packaged proc refers another packaged or standalone proc');
		x.p(' <li>',
				'pack1.proc1-> packs/pack1/proc1.ext : (.css, .js) <br/>
				a packaged proc refers it''s own one-to-one same-named js,css static files');
		x.p(' <li>',
				'pack1.procn-> packs/pack1/file.ext : (file.ext) <br/>
				a packaged/standalone proc refers it''s own static file ');
		x.p(' <li>',
				'any-> static/packn_or_procn/file.ext : (other_prog_x/file.ext) <br/>any code refers other packaged/standalone unit''s static files');
		x.p(' <li>',
				'pack1_b.procn-> pack1_c.procm : (@x.proc, @x/file.ext) <br/>
				refer same name unit but with a differ suffix, @ stand for name without _x suffix');
		x.p(' <li>',
				'any-> dir/file.txt : (dir/file.ext) <br/>
		    refer my dad/app''s normal static file');
	
		x.p(' <li>', '(./file.ext) <br/>refer my dad/app''s static file in root dir');
		x.p(' <li>', '(../app/..., \app/...) <br/>refer other dad/app''s normal static file');
		x.p(' <li>', '(/...) <br/>refer my http server''s path from root "/" ');
		x.p(' <li>', '( xxx://.../... ) <br/>refer other website''s url');
		x.p(' <li>',
				'([prefix_key]/path) <br/> refer other website''s url using re-allocatable key who maps to url prefix');
		x.p(' <li>',
				'allow static service to switch from between internal(same as plsql dynamic page server) and external servers, or move between external servers ');
		x.p(' <li>', 'switch [prefix] to third party''s backup path');
		x.c('</ol>');
	
		x.t('<br/>');
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to other dynamic pages.');
		x.a('<a>', 'proc1 in @x.proc form', '@b.proc1');
		x.a('<a>', 'easy_url_b.proc2 in pack.proc form', 'easy_url_b.proc2?p_b=ab.c&p1=LiYong');
		x.a('<a>', 'easy_url_b.proc2 in =pack.proc form', 'easy_url_b.proc2?p_b=ab.c&p1=LiYong');
		x.a('<a>', 'to standalone proc', './url_test1_b');
		x.a('<a>', 'to standalone proc in =proc', '=./url_test1_b');
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to static files.');
		x.p('<p>', 'this is myself''s img (CHN.gif)' || x.i('<img>', '@b/CHN.gif'));
		x.p('<p>', 'this is url_b''s img (url_b/CHN.gif)' || x.i('<img>', '^packs/url_b/CHN.gif'));
		x.p('<p>', 'this is url_test1_b''s img (url_test1_b/USA.gif)' || x.i('<img>', '^packs/url_test1_b/USA.gif'));
		x.p('<p>', 'this is ico/''s img (ico/google.ico)' || x.i('<img>', '^ico/google.ico'));
		x.p('<p>', 'this is img/nations/''s img (img/nations/JPN.gif)' || x.i('<img>', '^img/nations/JPN.gif'));
		x.p('<p>', 'this is app/dad''s root/''s img (./GER.gif)' || x.i('<img>', '^GER.gif'));
		x.p('<p>',
				'this is other dad''s img using  \ (\demo/packs/url_b/CHN.gif)' ||
				x.i('<img>', '\' || r.dbu || '/packs/url_b/CHN.gif'));
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to other site''s resources');
		x.p('<p>',
				'this is outsite''s img ([myself]/demo/img/nations/ITA.gif)' ||
				x.i('<img>', '[myself]' || '/demo/img/nations/ITA.gif'));
		x.p('<p>',
				'this is for abs path (http://www.oracleimg.com/us/assets/oralogo-small.gif)' ||
				x.i('<img>', 'http://www.oracleimg.com/us/assets/oralogo-small.gif'));
	
		x.t('<br/>');
		x.p('<p>', '>>> Links to other url schemas');
		x.p('<p>',
				x.a('<a>', 'javascript', 'javascript:alert("link to javascript")') || '(javascript:alert("link to javascript")');
	
		x.c('</body>');
		x.c('</html>');
	end;

	procedure link_transparent is
	begin
		src_b.header;
		x.a('<a>',
				'transparently(untouched) link to url without any particular prefix symbol in "=@*^\"',
				'ora_good_b.entry');
	end;

	procedure link_equal_to is
	begin
		src_b.header;
		x.p('<p>', x.a('<a>', 'link to url with "=" prefix', '=ora_good_b.entry'));
		x.p('<p>', x.a('<a>', 'back', 'javascript:history.back();'));
	end;

	procedure link_proc_in_same_pack is
	begin
		src_b.header;
		x.p('<p>', 'prefix "@" will be replaced by package name "x$pack" with last suffix character trimmed');
		x.a('<a>', 'link to procedure in the same package using "@x.xxx" pattern', '@b.link_equal_to');
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

end easy_url_b;
/
