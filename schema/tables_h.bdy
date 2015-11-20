create or replace package body tables_h is

	procedure xeditable is
		v_value varchar2(100) := r.getc('value');
		v_pk    varchar2(100) := r.getc('pk');
	begin
		if r.method = 'POST' then
			case r.getc('name')
				when 'name' then
					update user_t a set a.name = v_value where a.rowid = v_pk;
				when 'pass' then
					update user_t a set a.pass = v_value where a.rowid = v_pk;
			end case;
			return;
		end if;
		src_b.header;
		x.l('<link>', '[bootstrap.css]');
		x.j('<script>', '[jquery.js]');
		x.j('<script>', '[bootstrap.js]');
		x.l('<link>', '[bcdn]x-editable/1.5.1/bootstrap3-editable/css/bootstrap-editable.css');
		x.j('<script>', '[bcdn]x-editable/1.5.1/bootstrap3-editable/js/bootstrap-editable.min.js');
		x.p('<script>', x.r('$.fn.editable.defaults.mode = "@";', r.getc('mode', 'inline')));
		x.p('<style>', '.name{width:10em;}.pass{width:10em;}table{table-layout:fixed}td{padding:3px;}');
		x.o('<div.container-fluid>');
		x.o('<table.table.table-bordered>');
		for i in (select a.*, rowid rid from user_t a) loop
			x.o('<tr>');
			x.p(' <td.name ^name=name,^pk=:1>', i.name, st(i.rid));
			x.p(' <td.pass ^name=pass,^pk=:1>', i.pass, st(i.rid));
			x.c('</tr>');
		end loop;
		x.c('</table>');
	
		x.t('<script>
		$(document).ready(function(){
			$(".name").editable({
			  type : "text",
				url : "tables_h.xeditable",
				title : "enter username"
			});	
			$(".pass").editable({
			  type : "text",
				pk : 1,
				url : "tables_h.xeditable",
				title : "enter password"
			});	
		});</script>');
	end;

	procedure handsontable is
		cur sys_refcursor;
	begin
		if r.is_xhr then
			open cur for
				select rowid rid, a.* from user_t a;
			rs.print(cur);
			return;
		end if;
		src_b.header;
		x.j('<script>', '[jquery.js]');
		x.l('<link>', '[bcdn]jquery-handsontable/0.10.2/jquery.handsontable.full.min.css');
		x.j('<script>', '[bcdn]jquery-handsontable/0.10.2/jquery.handsontable.full.min.js');
		x.p('<div#example>', '');
		x.t('<script>
		$.get(location.href, function(obj){
			var head = obj.$DATA.attrs.map(function(v){return v.name;});
			var data = obj.$DATA.rows.map(function(v){
			  return [ v[head[0]],v[head[1]],v[head[2]],v[head[3]],v[head[4]] ];
			});
			data.unshift(head);
			$("#example").handsontable({
				data: data,
				minSpareRows: 1,
				rowHeaders: true,
				colHeaders: true,
				contextMenu: true
		  });
		});
		</script>');
	end;
	
	-- procedure http://datatables.net/

end tables_h;
/
