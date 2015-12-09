create or replace package body bootstrap_b is

	-- public
	procedure use_lib is
	begin
		b.l('<!DOCTYPE html>');
		o.t('<html>');
		o.t(' <head>');
		o.t('  <meta name=viewport content="width=device-width, initial-scale=1"/>');
		o.u('  <link rel=stylesheet/>', '[bootstrap.css]');
		o.u('  <script>', '[jquery.js]', '');
		o.u('  <script>', '[bootstrap.js]', '');
		o.t(' </head>');
		o.t(' <body>');
		o.t('<h2>', o.u('<a target=_blank>', 'http://getbootstrap.com/', 'bootstrap official site'));
	end;

	procedure navs(p_type varchar2) is
	begin
		o.p(1, p_type = 'packages');
		o.p(2, p_type = 'tables');
		o.p(3, p_type = 'images');
		o.t('<ul.nav.nav-tabs.nav-pills.nav-justified>');
		o.t(' <li.active?>', o.u('<a>', '@b.packages', 'packages'));
		o.t(' <li.active?>2', o.u('<a>', '@b.tables', 'tables'));
		o.t(' <li.dropdown.active?>3');
		o.u('  <a.dropdown-toggle -toggle=dropdown>', '@b.images', 'images ' || o.t('<span.caret>', ''));
		o.t('  <ul.dropdown-menu>');
		o.t('   <li>', o.u('<a>', '@b.images?cols=1', '1'));
		o.t('   <li>', o.u('<a>', '@b.images?cols=2', '2'));
		o.t('   <li>', o.u('<a>', '@b.images?cols=3', '3'));
		o.t('   <li>', o.u('<a>', '@b.images?cols=4', '4'));
		o.t('   <li>', o.u('<a>', '@b.images?cols=6', '6'));
		o.t('  </ul>');
		o.t(' </li>');
		o.t('</ul>');
		o.t('<div.container-fluid>');
	end;

	procedure packages is
		p_oname varchar2(100) := upper(nvl(r.getc('oname', '%'), '%'));
	begin
		use_lib;
		--o.t('<h1>', lengthb(p_oname));
		navs('packages');
	
		-- form
		o.u('<form.form-inline role=form method=get>', r.prog);
		o.t(' <div.form-group>');
		o.t('  <lable>', 'object name');
		o.t('  <input.form-control type=text name=oname placeholder=%/>');
		o.t(' </div>');
		o.t(' <div.form-group>');
		o.t('  <lable>', 'create after');
		o.t('  <input.form-control type=datetime name=created placeholder="created after"/>');
		o.t(' </div>');
		o.t(' <input.btn.btn-primary type=submit/>');
		o.t('</form>');
	
		--o.t('<div.table-responsive>');
		o.t('<table.table.table-striped.table-bordered.table-hover.table-condensed>');
		o.t(' <thead>');
		o.t('  <tr>');
		o.t('   <th>', 'object name');
		o.t('   <th>', 'create time');
		o.t('   <th>', 'operations');
		o.t('  </tr>');
		o.t(' </thead>');
		o.t(' <tbody>');
		for i in (select a.*
								from user_objects a
							 where a.object_type = 'PACKAGE'
								 and a.object_name like p_oname) loop
			o.t('<tr>');
			o.t(' <td>', i.object_name);
			o.t(' <td>', i.created);
			o.t(' <td>',
					o.u('<a.btn.btn-sm.btn-default role=button>',
							'@b.show_code?pack=' || i.object_name,
							o.t('<span.glyphicon.glyphicon-eye-open>', '') || ' view'));
			o.t('</tr>');
		end loop;
		o.t(' </tbody>');
		o.t('</table>');
		--o.t('</div>');
	end;

	procedure tables is
		p_oname varchar2(100) := upper(nvl(r.getc('oname', '%'), '%'));
	begin
		use_lib;
		navs('tables');
	
		o.t('<table.table.table-bordered>');
		o.t(' <thead>');
		o.t('  <tr>');
		o.t('   <th>', 'table name');
		o.t('   <th>', 'num-of-rows');
		o.t('   <th>', 'partition');
		o.t('   <th>', 'operations');
		o.t('  </tr>');
		o.t(' </thead>');
		o.t(' <tbody>');
		for i in (select a.* from user_tables a where a.table_name like p_oname) loop
			o.t('<tr>');
			o.t(' <td>', i.table_name);
			o.t(' <td>', i.num_rows);
			o.t(' <td>', i.partitioned);
			o.t(' <td>', o.u('<a>', '@b.table_detail?tname=' || i.table_name, ' view'));
			o.t('</tr>');
		end loop;
		o.t(' </tbody>');
		o.t('</table>');
	end;

	procedure show_code is
		p_pack varchar2(32) := r.getc('pack');
		v_flag boolean := true;
	begin
		use_lib;
		o.t('<div.dropdown.pull-right style="display:inline-block;">');
		o.t(' <button.btn.btn-default.dropdown-toggle -toggle=dropdown>', 'navigate ' || o.t('<span.caret>', ''));
		o.t(' <ul.dropdown-menu.dropdown-menu-right>');
		o.t('  <li>', o.u('<a>', '#spec', 'go spec'));
		o.t('  <li>', o.u('<a>', '#body', 'go body'));
		o.t('  <li>', o.u('<a>', '#end', 'go end'));
		o.t('  <li.divider>', '');
		o.t('  <li>', o.u('<a>', r.referer, 'go back'));
		o.t(' </ul>');
		o.t('</div>');
	
		o.t('<pre>');
		o.t('<a name=spec>', '');
		for i in (select a.* from user_source a where a.name = p_pack order by a.type asc, a.line asc) loop
			if v_flag and i.type = 'PACKAGE BODY' then
				b.l('<hr/>');
				v_flag := false;
				o.t('<a name=body>', '');
			end if;
			b.l(t.e(replace(replace(i.text, chr(10), ''), chr(9), '&nbsp;&nbsp;')));
		end loop;
		o.t('<a name=end>', '');
		o.t('</pre>');
	end;

	procedure button_toolbar is
		v_st   st := st('lg', '', 'sm', 'xs');
		v_base varchar2(100) := r.prog || '?cols=';
	begin
		o.t('<div.btn-toolbar style=margin:3px 6px;>');
		for i in 1 .. 4 loop
			o.p(1, v_st(i));
			o.t('<div.btn-group.btn-group-?>');
			o.u(' <a.btn.btn-default>', v_base || '1', '1');
			o.u(' <a.btn.btn-default>', v_base || '2', '2');
			o.u(' <a.btn.btn-default>', v_base || '3', '3');
			o.u(' <a.btn.btn-default>', v_base || '4', '4');
			o.u(' <a.btn.btn-default>', v_base || '6', '6');
			o.t('</div>');
		end loop;
		o.t('</div>');
	end;

	procedure images is
	begin
		use_lib;
		navs('images');
		button_toolbar;
		o.p(1, r.getc('cols', '3'));
		o.t('<div.container>');
		o.t(' <div.row>');
		for i in 1 .. 24 loop
			o.t('<div.col-xs-?>', o.u('<img.img-responsive.img-thumbnail.img-circle/>', '^img/larry.jpg'));
		end loop;
		o.t(' </div>');
		o.t('</div>');
	end;

end bootstrap_b;
/
