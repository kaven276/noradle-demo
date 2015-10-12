create or replace procedure url_test1_b is
begin
	x.o('<html>');
	x.o('<head>');
	x.l(' <link>', '*.css');
	x.j(' <script>', '*.js');
	x.c('</head>');
	x.o('<body>');
	x.p('<p>', 'I''m a standalone procedure');
	x.p('<style>', 'a{display:block;} p{margin:0.2em;}');

	x.p('<p>', 'r.prog=' || r.prog);
	x.p('<p>', 'r.pack=' || r.pack);
	x.p('<p>', 'r.proc=' || r.proc);

	x.t('<hr/>');

	x.p('<h3>', 'link to servlet demo');
	x.p('<p>', x.a('<a>', 'link to "pack.proc" pattern from standalone procedure', './easy_url_b.d'));
	x.p('<p>', x.a('<a>', 'link to standalone proc(for demo, self) pattern from standalone procedure', './url_test1_b'));

	x.p('<h3>', 'link to static demo');
	x.p('<p>', 'this is my plsql unit(standalone procedure)''s img ' || x.i('<img>', '@b/USA.gif'));
	x.p('<p>', 'this is some package(easy_url_b)''s img ' || x.i('<img>', '^packs/easy_url_b/CHN.gif'));
	x.p('<p>', 'this is some standalone procedure(url_test1_b)''s img ' || x.i('<img>', '^packs/url_test1_b/USA.gif'));
	x.p('<p>', 'this is img/nations/''s img ' || x.i('<img>', '^img/nations/JPN.gif'));
	x.p('<p>', 'this is img directly under static root' || x.i('<img>', '^GER.gif'));

end url_test1_b;
/
