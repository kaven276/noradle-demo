create or replace package body tree_b is

	procedure parse_render_in_loop is
		cur sys_refcursor;
	begin
		src_b.header;
		x.p('<h2>', 'use tree.p, tree.o, tree,r, tree.c to print tree');
	
		x.o('<ul>');
		tr.p(' <li class="xing-@"><a href="see?pid=@">@</a>|<ul>|</ul>|</li>', tmp.stv);
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
		x.p('<h2>', 'use tree.rc(sys_refcursor) to print tree');
		open cur for
			select level, substr(a.name, 1, 1), a.pid, a.name
				from emp_t a
			 start with a.name = 'Li Xinyan'
			connect by a.ppid = prior a.pid;
		x.o('<ul>');
		tr.p('<li class="xing-@"><a href="see?pid=@">@</a>|<ul>|</ul>|</li>', tmp.stv);
		tr.o(true);
		tr.rc(tmp.stv, cur);
		tr.c(tmp.stv);
		x.c('</ul>');
	end;

	procedure parse_render_cur_united is
		cur sys_refcursor;
	begin
		src_b.header;
		x.p('<h2>', 'use tree.prc(sys_refcursor) to print tree in one step');
		open cur for
			select level, substr(a.name, 1, 1), a.name
				from emp_t a
			 start with a.name = 'Li Xinyan'
			connect by a.ppid = prior a.pid;
		x.o('<ul>');
		tr.prc('<li class="xing-@"><b>@</b>|<ul>|</ul>|</li>', cur, pretty => true);
		x.c('</ul>');
	end;

	procedure hier_node_level_in_loop is
		cur sys_refcursor;
	begin
		src_b.header;
		x.p('<h2>', 'use tree.p, tree.o, tree,r, tree.n(by level), tree.c to print tree');
		x.o('<ul>');
		tr.p('<li class="xing-@"><a href="see?pid=@">@</a>|<ul>|</ul>|</li>', tmp.stv);
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
