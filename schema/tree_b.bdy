create or replace package body tree_b is

	procedure tree_css is
	begin
		x.l('<link>', '[bootstrap.css]');
		b.l('<style>
		.root {
		  font-size :36px;
		}
		.branch {
			margin-left : 0.22em;
			border-left: 1px solid silver;
			padding-left : 0.82em;
		}
		.root > li,
		.branch > li {
			list-style: none;
		}
		.node {
		  line-height: 1.7;
		}
		.node > .handle {
			font-size: 0.5em;
			color: black;
		}
		.node > .icon {
			font-size: 0.8em;
			margin-left: 0.5em;
			margin-right: 0.5em;
		}
		.node > a,
		.node > b {
			padding: 3px 10px 3px;
			border: 1px solid silver;
			border-radius: 6px;
		}
		.node > a:hover {
		  text-decoration: none;
			background-color: silver;
		}
		</style>');
	end;

	procedure parse_render_in_loop is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css;
		x.p('<h2>', 'use tree.p, tree.o, tree,r, tree.c to print tree');
	
		x.o('<ul.root>');
		b.begin_template;
		x.o('<li.xing-@>');
		x.o(' <span.node>');
		x.p('  <i.handle.glyphicon.glyphicon-plus>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a>', '@', 'see?pid=@ ');
		x.c(' </span>');
		x.t('|');
		x.p(' <ul.branch>', '|');
		x.t('|');
		x.c('</li>');
		b.end_template(tmp.s);
		tr.p(tmp.s, tmp.stv);
		tr.o(true);
		for a in (select level, substr(a.name, 1, 1), a.pid, a.name
								from emp_t a
							 start with a.name = 'Li Xinyan'
							connect by a.ppid = prior a.pid) loop
			tr.r(a.level, tmp.stv, st(substr(a.name, 1, 1), a.pid, a.name));
		end loop;
		tr.c;
		x.c('</ul>');
	end;

	procedure parse_open_render_cur_close is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css;
		x.p('<h2>', 'use tree.rc(sys_refcursor) to print tree');
		open cur for
			select level, substr(a.name, 1, 1), a.pid, a.name
				from emp_t a
			 start with a.name = 'Li Xinyan'
			connect by a.ppid = prior a.pid;
		x.o('<ul.root>');
		b.begin_template;
		x.o('<li.xing-@>');
		x.o(' <span.node>');
		x.p('  <i.handle.glyphicon.glyphicon-plus>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a>', '@', 'see?pid=@ ');
		x.c(' </span>');
		x.t('|');
		x.p(' <ul.branch>', '|');
		x.t('|');
		x.c('</li>');
		b.end_template(tmp.s);
		tr.p(tmp.s, tmp.stv);
		tr.o(true);
		tr.rc(tmp.stv, cur);
		tr.c(tmp.stv);
		x.c('</ul>');
	end;

	procedure parse_render_cur_united is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css;
		x.p('<h2>', 'use tree.prc(sys_refcursor) to print tree in one step');
		open cur for
			select level, substr(a.name, 1, 1), a.name
				from emp_t a
			 start with a.name = 'Li Xinyan'
			connect by a.ppid = prior a.pid;
		x.o('<ul.root>');
		b.begin_template;
		x.o('<li.xing-@>');
		x.o(' <span.node>');
		x.p('  <i.handle.glyphicon.glyphicon-plus>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.p('  <b>', '@');
		x.c(' </span>');
		x.t('|');
		x.p(' <ul.branch>', '|');
		x.t('|');
		x.c(' </li>');
		b.end_template(tmp.s);
		tr.prc(tmp.s, cur, pretty => true);
		x.c('</ul>');
	end;

	procedure hier_node_level_in_loop is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css;
		x.p('<h2>', 'use tree.p, tree.o, tree,r, tree.n(by level), tree.c to print tree');
		x.o('<ul.root>');
		b.begin_template;
		x.o('<li.xing-@>');
		x.o(' <span.node>');
		x.p('  <i.handle.glyphicon.glyphicon-plus>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a>', '@', 'see?pid=@ ');
		x.c(' </span>');
		x.t('|');
		x.p(' <ul.branch>', '|');
		x.t('|');
		x.c('</li>');
		b.end_template(tmp.s);
		tr.p(tmp.s, tmp.stv);
		tr.o(true);
		for a in (select level, substr(a.name, 1, 1), a.pid, a.name
								from emp_t a
							 start with a.name = 'Li Xinyan'
							connect by a.ppid = prior a.pid) loop
			tr.n(a.level, m.r(tmp.stv, st(substr(a.name, 1, 1), a.pid, a.name)));
		end loop;
		tr.c;
		x.c('</ul>');
	end;

	procedure hier_node_all_types is
	begin
		src_b.header;
		x.p('<h2>', 'use tree.p, tree.o, tree.n(all types), tree.c to print tree');
		x.o('<ul>');
		tr.o(true);
	
		tr.n(1, '<li>' || x.a('<a>', 'file', '#'));
		tr.n(2, '<li>' || x.a('<a>', 'new', '#'));
		tr.n(2, '<li>' || x.a('<a>', 'open', '#'));
		tr.n(2, '<li>' || x.a('<a>', 'close', '#'));
		tr.n(3, '<li>' || x.a('<a>', 'close all', '#'));
		tr.n(3, '<li>' || x.a('<a>', 'close current', '#'));
		tr.n(2, '<li>' || x.a('<a>', 'save', '#'));
		tr.n(3, '<li>' || x.a('<a>', 'save all', '#'));
		tr.n(3, '<li>' || x.a('<a>', 'save current', '#'));
	
		tr.n(' ', '<li>' || x.a('<a>', 'file', '#'));
		tr.n('  ', '<li>' || x.a('<a>', 'new', '#'));
		tr.n('  ', '<li>' || x.a('<a>', 'open', '#'));
		tr.n('  ', '<li>' || x.a('<a>', 'close', '#'));
		tr.n('   ', '<li>' || x.a('<a>', 'close all', '#'));
		tr.n('   ', '<li>' || x.a('<a>', 'close current', '#'));
		tr.n('  ', '<li>' || x.a('<a>', 'save', '#'));
		tr.n('   ', '<li>' || x.a('<a>', 'save all', '#'));
		tr.n('   ', '<li>' || x.a('<a>', 'save current', '#'));
	
		tr.n(' <li>' || x.a('<a>', 'file', '#'));
		tr.n('  <li>' || x.a('<a>', 'new', '#'));
		tr.n('  <li>' || x.a('<a>', 'open', '#'));
		tr.n('  <li>' || x.a('<a>', 'close', '#'));
		tr.n('   <li>' || x.a('<a>', 'close all', '#'));
		tr.n('   <li>' || x.a('<a>', 'close current', '#'));
		tr.n('  <li>' || x.a('<a>', 'save', '#'));
		tr.n('   <li>' || x.a('<a>', 'save all', '#'));
		tr.n('   <li>' || x.a('<a>', 'save current', '#'));
	
		tr.n(' <li>', x.a('<a>', 'file', '#'));
		tr.n('  <li>', x.a('<a>', 'new', '#'));
		tr.n('  <li>', x.a('<a>', 'open', '#'));
		tr.n('  <li>', x.a('<a>', 'close', '#'));
		tr.n('   <li>', x.a('<a>', 'close all', '#'));
		tr.n('   <li>', x.a('<a>', 'close current', '#'));
		tr.n('  <li>', x.a('<a>', 'save', '#'));
		tr.n('   <li>', x.a('<a>', 'save all', '#'));
		tr.n('   <li>', x.a('<a>', 'save current', '#'));
	
		tr.c;
		x.c('</ul>');
	end;

end tree_b;
/
