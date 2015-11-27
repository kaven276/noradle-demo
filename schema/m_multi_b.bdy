create or replace package body m_multi_b is

	procedure wrap_each_array_value is
	begin
		src_b.header;
		x.o('<ol>');
		m.w(' <li>', st('a', 'b'), '</li>');
		x.c('</ol>');
		x.p('<ul>', m.w('<li>', st('a', 'b'), '</li>'));
	
		x.o('<ol>');
		m.w('<li>@</li>', st('a', 'b'));
		m.w('<li>@</li>', 'a,b');
		x.c('</ol>');
	
		x.p('<ul>', m.w('<li>@</li>', st('name', 'manager', 'phone', 'admin', 'level')));
		x.p('<ul>', m.w('<li>@</li>', 'name,manager,phone,admin,level'));
	end;

	procedure wrap_array_in_loop is
		v_total pls_integer := 0;
		cursor c is
			select a.object_name pack, count(a.procedure_name) pcnt
				from user_procedures a
			 where a.object_type = 'PACKAGE'
				 and a.procedure_name is not null
			 group by a.object_name;
	begin
		src_b.header;
		x.o('<table rules=all,cellspacing=8>');
		x.p(' <thead>', x.p('<tr>', m.w('<th>@</th>', 'package,number of procedures')));
		x.o(' <tbody>');
		for i in c loop
			x.p('<tr>', m.w('<td>', st(i.pack, i.pcnt), '</td>'));
			v_total := v_total + i.pcnt;
		end loop;
		x.c(' </tbody>');
		x.p(' <tfoot>', x.p('<tr>', m.w('<th>@</th>', st('total', v_total))));
		x.c('</table>');
	end;

	procedure parse_render_st is
		cursor c is
			select rownum rid, a.object_name, a.object_type from user_objects a where rownum < = 3;
	begin
		src_b.header;
		x.o('<table rules=all,cellspacing=8>');
		x.p(' <caption>', 'm.parse once, m.render repeatly, high proformance');
		m.p(' <tr><th>@</th><td>@</td><td>@</td></tr>', tmp.stv);
		for i in c loop
			m.r(tmp.stv, st(to_char(i.rid, '09'), i.object_type, i.object_name));
		end loop;
		x.c('</table>');
	end;

	procedure parse_render_st_boolean is
		svs varchar2(4000) := r.getc('sv', 'AUTH_B,BASIC_IO_B');
		cursor c is
			select a.object_id, a.object_name from user_objects a where rownum < 10;
	begin
		src_b.header;
		x.p('<h1>', 'checkboxes / procedure edition');
		x.o('<fieldset>');
		x.p(' <legend>', 'checkbox groups');
		x.o(' <div>');
		m.p(' <label><input @ type="checkbox" name="single" value="@"/>@</label><br/>', tmp.stv);
		for i in c loop
			m.r(tmp.stv, st(t.tf(t.inlist(svs, i.object_name), 'checked'), i.object_id, i.object_name));
		end loop;
		x.c(' </div>');
		x.c('</fieldset>');
	end;

	procedure parse_render_cursor is
		cur sys_refcursor;
	begin
		src_b.header;
		open cur for
			select a.object_name, a.object_type from user_objects a where rownum <= 3;
		x.p('<p>', 'sys_refcursor to simple fill ul list');
		x.o('<ul>');
		m.prc('<li><b>@</b><small> - (@)</small></li>', cur);
		x.c('</ul>');
	end;

	procedure nv_form_select_options is
		cur sys_refcursor;
		sv  varchar2(4000) := r.getc('sv', 'AUTH_B');
		svs varchar2(4000) := r.getc('sv', 'AUTH_B,BASIC_IO_B');
	begin
		src_b.header;
	
		open cur for
			select a.object_id, a.object_name from user_objects a where rownum < 10;
		x.p('<h1>', 'multiple select options / procedure edition');
		x.o('<select multiple name=select,size=6>');
		m.nv('<option ?selected value="@"/>@</option>', cur, svs);
		x.c('</select>');
		x.t('<br/>');
	
		open cur for
			select a.object_id, a.object_name from user_objects a where rownum < 10;
		x.p('<h1>', 'single select options / function edition');
		x.p('<select name=select>', m.nv('<option ?selected value="@"/>@</option>', cur, sv));
		x.t('<br/>');
	end;

	procedure nv_form_radios is
		cur sys_refcursor;
		sv  varchar2(4000) := r.getc('sv', 'AUTH_B');
	begin
		src_b.header;
		open cur for
			select a.object_id, a.object_name from user_objects a where rownum < 10;
		x.p('<h1>', 'radios / function edition');
		x.o('<fieldset>');
		x.p(' <legend>', 'radio groups');
		x.p(' <div>', m.nv('<label><input ?checked type="radio" name="single" value="@"/>@</label><br/>', cur, sv));
		x.c('</fieldset>');
	end;

	procedure nv_form_checkboxes is
		cur sys_refcursor;
		svs varchar2(4000) := r.getc('sv', 'AUTH_B,BASIC_IO_B');
	begin
		src_b.header;
		open cur for
			select a.object_id, a.object_name from user_objects a where rownum < 10;
		x.p('<h1>', 'checkboxes / procedure edition');
		x.o('<fieldset>');
		x.p(' <legend>', 'checkbox groups');
		x.o(' <div>');
		m.nv(' <label><input ?checked type="checkbox" name="single" value="@"/>@</label><br/>', cur, svs);
		x.c(' </div>');
		x.c('</fieldset>');
	end;

end m_multi_b;
/
