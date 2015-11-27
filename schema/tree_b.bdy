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

	procedure tree_css2 is
	begin
		x.l('<link>', '[bootstrap.css]');
		x.j('<script>', '[jquery.js]');
		x.j('<script>', '[bootstrap.js]');
		b.l('<style>
		.root {
		  font-size :36px;
		}
		.branch {
			margin-left : 0.22em;
			border-left: 1px solid silver;
			padding-left : 0.82em;
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
		.node > .text {
			padding: 3px 10px 3px;
			border: 1px solid silver;
			border-radius: 6px;
		}
		.node > a.text:hover {
		  text-decoration: none;
			background-color: silver;
		}
		.handle.glyphicon:before {
		  color: silver;
		}
		.node.selected > .icon {
		  color: orange;
		}
		.node.selected > .text {
		  background-color: orange;
		}
		</style>
		<script>
		$(function(){
		  $(".root")
			.on("click", ".icon, .text", function(e){
			  $(this).parent().toggleClass("selected");
			})
			.on("click", ".node > .handle", function(e){
			  $(this).parent().next(".branch").collapse("toggle");
			})
			.on("hidden.bs.collapse show.bs.collapse", ".collapse", function (event) {
			  event.stopPropagation()
			  $(this).prev().find(".handle")
				  .toggleClass("glyphicon-triangle-bottom")
					.toggleClass("glyphicon-triangle-right");
			})
			.find(".node").each(function(){
			  console.log(".node", $(this).text());
			}).filter(function(){
			  return $(this).next(".branch").length === 0;
			}).find(".handle")
			  .removeClass("glyphicon-triangle-right")
				.addClass("glyphicon-unchecked");
		});
		</script>');
	
	end;

	procedure parse_render_in_loop is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css2;
		x.o('<div.container-fluid>');
		x.p('<h2>', 'use tree.p, tree.o, tree,r, tree.c to print tree');
	
		x.o('<div.root>');
		b.begin_template;
		x.o('<div.node>');
		x.p('  <i.handle.glyphicon.glyphicon-triangle-right>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a.text>', '@ @', 'tele://@ ');
		x.c('</div>');
		x.t('|');
		x.p(' <div.branch.collapse>', '|');
		x.t('|');
		b.end_template(tmp.s);
		tr.p(tmp.s, tmp.stv);
		tr.o(true);
		for i in (select e.*,
										 level as lvl,
										 connect_by_isleaf as is_leaf,
										 sys_connect_by_path(last_name, '/') as path,
										 connect_by_root last_name as manager
								from employees e
							 start with e.manager_id = (select a.employee_id from employees a where a.manager_id is null)
							connect by prior e.employee_id = e.manager_id
							 order siblings by e.last_name asc) loop
			tr.r(i.lvl, tmp.stv, st(i.phone_number, i.first_name, i.last_name));
		end loop;
		tr.c;
		x.c('</div>');
	end;

	procedure parse_open_render_cur_close is
		cur sys_refcursor;
	begin
		src_b.header;
		tree_css2;
		x.p('<h2>', 'use tree.rc(sys_refcursor) to print tree');
		open cur for
			select level as lvl, e.phone_number, e.first_name, e.last_name
				from employees e
			 start with e.manager_id = (select a.employee_id from employees a where a.manager_id is null)
			connect by prior e.employee_id = e.manager_id
			 order siblings by e.last_name asc;
		x.o('<div.root>');
		b.begin_template;
		x.o('<div.node>');
		x.p('  <i.handle.glyphicon.glyphicon-triangle-right>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a.text>', '@ @', 'tele://@ ');
		x.c('</div>');
		x.t('|');
		x.p(' <div.branch.collapse>', '|');
		x.t('|');
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
		tree_css2;
		x.p('<h2>', 'use tree.prc(sys_refcursor) to print tree in one step');
		open cur for
			select level as lvl, e.phone_number, e.first_name, e.last_name
				from employees e
			 start with e.manager_id = (select a.employee_id from employees a where a.manager_id is null)
			connect by prior e.employee_id = e.manager_id
			 order siblings by e.last_name asc;
		x.o('<div.root>');
		b.begin_template;
		x.o('<div.node>');
		x.p('  <i.handle.glyphicon.glyphicon-triangle-right>');
		x.p('  <i.icon.glyphicon.glyphicon-user>');
		x.a('  <a.text>', '@ @', 'tele://@ ');
		x.c('</div>');
		x.t('|');
		x.p(' <div.branch.collapse>', '|');
		x.t('|');
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
