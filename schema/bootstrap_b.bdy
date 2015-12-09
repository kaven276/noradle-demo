create or replace package body bootstrap_b is

	-- public
	procedure use_lib is
	begin
		b.l('<!DOCTYPE html>');
		j.t('<html>');
		j.t(' <head>');
		j.t('  <meta name=viewport content="width=device-width, initial-scale=1"/>');
		j.u('  <link rel=stylesheet/>', '[bootstrap.css]');
		j.u('  <script>', '[jquery.js]', '');
		j.u('  <script>', '[bootstrap.js]', '');
		j.t(' </head>');
		j.t(' <body>');
	end;

	procedure navs(p_type varchar2) is
	begin
		j.p(1, p_type = 'packages');
		j.p(2, p_type = 'tables');
		j.p(3, p_type = 'images');
		j.t('<ul.nav.nav-tabs.nav-pills.nav-justified>');
		j.t(' <li.active?>', j.u('<a>', '@b.packages', 'packages'));
		j.t(' <li.active?>2', j.u('<a>', '@b.tables', 'tables'));
		j.t(' <li.dropdown.active?>3');
		j.u('  <a.dropdown-toggle -toggle=dropdown>', '@b.images', 'images ' || j.t('<span.caret>', ''));
		j.t('  <ul.dropdown-menu>');
		j.t('   <li>', j.u('<a>', '@b.images?cols=1', '1'));
		j.t('   <li>', j.u('<a>', '@b.images?cols=2', '2'));
		j.t('   <li>', j.u('<a>', '@b.images?cols=3', '3'));
		j.t('   <li>', j.u('<a>', '@b.images?cols=4', '4'));
		j.t('   <li>', j.u('<a>', '@b.images?cols=6', '6'));
		j.t('  </ul>');
		j.t(' </li>');
		j.t('</ul>');
		j.t('<div.container-fluid>');
	end;

	procedure packages is
		p_oname varchar2(100) := upper(nvl(r.getc('oname', '%'), '%'));
	begin
		use_lib;
		--j.t('<h1>', lengthb(p_oname));
		navs('packages');
	
		-- form
		j.u('<form.form-inline role=form method=get>', r.prog);
		j.t(' <div.form-group>');
		j.t('  <lable>', 'object name');
		j.t('  <input.form-control type=text name=oname placeholder=%/>');
		j.t(' </div>');
		j.t(' <div.form-group>');
		j.t('  <lable>', 'create after');
		j.t('  <input.form-control type=datetime name=created placeholder="created after"/>');
		j.t(' </div>');
		j.t(' <input.btn.btn-primary type=submit/>');
		j.t('</form>');
	
		--j.t('<div.table-responsive>');
		j.t('<table.table.table-striped.table-bordered.table-hover.table-condensed>');
		j.t(' <thead>');
		j.t('  <tr>');
		j.t('   <th>', 'object name');
		j.t('   <th>', 'create time');
		j.t('   <th>', 'operations');
		j.t('  </tr>');
		j.t(' </thead>');
		j.t(' <tbody>');
		for i in (select a.*
								from user_objects a
							 where a.object_type = 'PACKAGE'
								 and a.object_name like p_oname) loop
			j.t('<tr>');
			j.t(' <td>', i.object_name);
			j.t(' <td>', i.created);
			j.t(' <td>',
					j.u('<a.btn.btn-sm.btn-default role=button>',
							'@b.show_code?pack=' || i.object_name,
							j.t('<span.glyphicon.glyphicon-eye-open>', '') || ' view'));
			j.t('</tr>');
		end loop;
		j.t(' </tbody>');
		j.t('</table>');
		--j.t('</div>');
	end;

	procedure tables is
		p_oname varchar2(100) := upper(nvl(r.getc('oname', '%'), '%'));
	begin
		use_lib;
		navs('tables');
	
		j.t('<table.table.table-bordered>');
		j.t(' <thead>');
		j.t('  <tr>');
		j.t('   <th>', 'table name');
		j.t('   <th>', 'num-of-rows');
		j.t('   <th>', 'partition');
		j.t('   <th>', 'operations');
		j.t('  </tr>');
		j.t(' </thead>');
		j.t(' <tbody>');
		for i in (select a.* from user_tables a where a.table_name like p_oname) loop
			j.t('<tr>');
			j.t(' <td>', i.table_name);
			j.t(' <td>', i.num_rows);
			j.t(' <td>', i.partitioned);
			j.t(' <td>', j.u('<a>', '@b.table_detail?tname=' || i.table_name, ' view'));
			j.t('</tr>');
		end loop;
		j.t(' </tbody>');
		j.t('</table>');
	end;

	procedure show_code is
		p_pack varchar2(32) := r.getc('pack');
		v_flag boolean := true;
	begin
		use_lib;
		j.t('<div.dropdown.pull-right style="display:inline-block;">');
		j.t(' <button.btn.btn-default.dropdown-toggle -toggle=dropdown>', 'navigate ' || j.t('<span.caret>', ''));
		j.t(' <ul.dropdown-menu.dropdown-menu-right>');
		j.t('  <li>', j.u('<a>', '#spec', 'go spec'));
		j.t('  <li>', j.u('<a>', '#body', 'go body'));
		j.t('  <li>', j.u('<a>', '#end', 'go end'));
		j.t('  <li.divider>', '');
		j.t('  <li>', j.u('<a>', r.referer, 'go back'));
		j.t(' </ul>');
		j.t('</div>');
	
		j.t('<pre>');
		j.t('<a name=spec>', '');
		for i in (select a.* from user_source a where a.name = p_pack order by a.type asc, a.line asc) loop
			if v_flag and i.type = 'PACKAGE BODY' then
				b.l('<hr/>');
				v_flag := false;
				j.t('<a name=body>', '');
			end if;
			b.l(t.e(replace(replace(i.text, chr(10), ''), chr(9), '&nbsp;&nbsp;')));
		end loop;
		j.t('<a name=end>', '');
		j.t('</pre>');
	end;

	procedure button_toolbar is
		v_st   st := st('lg', '', 'sm', 'xs');
		v_base varchar2(100) := r.prog || '?cols=';
	begin
		j.t('<div.btn-toolbar style=margin:3px 6px;>');
		for i in 1 .. 4 loop
			j.p(1, v_st(i));
			j.t('<div.btn-group.btn-group-?>');
			j.u(' <a.btn.btn-default>', v_base || '1', '1');
			j.u(' <a.btn.btn-default>', v_base || '2', '2');
			j.u(' <a.btn.btn-default>', v_base || '3', '3');
			j.u(' <a.btn.btn-default>', v_base || '4', '4');
			j.u(' <a.btn.btn-default>', v_base || '6', '6');
			j.t('</div>');
		end loop;
		j.t('</div>');
	end;

	procedure images is
	begin
		use_lib;
		navs('images');
		button_toolbar;
		j.p(1, r.getc('cols', '3'));
		j.t('<div.container>');
		j.t(' <div.row>');
		for i in 1 .. 24 loop
			j.t('<div.col-xs-?>', j.u('<img.img-responsive.img-thumbnail.img-circle/>', '^img/larry.jpg'));
		end loop;
		j.t(' </div>');
		j.t('</div>');
	end;

end bootstrap_b;
/
