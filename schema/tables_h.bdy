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
		j.u('<link rel=stylesheet/>', '[bootstrap.css]');
		j.u('<script>', '[jquery.js]', '');
		j.u('<script>', '[bootstrap.js]', '');
		j.u('<link rel=stylesheet/>', '[bootstrap-editable.css]');
		j.u('<script>', '[bootstrap-editable.js]', '');
		j.t('<script>', t.fill('$.fn.editable.defaults.mode = "@";', r.getc('mode', 'inline')));
		j.t('<style>',
				'.name{width:10em;}
				 .pass{width:10em;}
		     table{table-layout:fixed}
				 td{padding:3px;}');
		j.t('<div.container-fluid>');
		j.t('<h3.page-header>', j.u('<a target=_blank>', 'http://vitalets.github.io/x-editable/', 'x-editable'));
		j.t('<table.table.table-bordered>');
		for i in (select a.*, rowid rid from user_t a) loop
			j.p(1, i.rid);
			j.t('<tr>');
			j.t(' <td.name -name=name -pk=?>', i.name);
			j.t(' <td.pass -name=pass -pk=?>', i.pass);
			j.t('</tr>');
		end loop;
		j.t('</table>');
	
		b.l('<script>
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
				select rowid rid, a.* from countries a;
			rs.print(cur);
			return;
		end if;
		src_b.header;
		j.u('<script>', '[jquery.js]', '');
		j.u('<link rel=stylesheet/>', '[jquery.handsontable.full.css]');
		j.u('<script>', '[jquery.handsontable.full.js]', '');
		j.t('<h3.page-header>', j.u('<a target=_blank>', 'http://handsontable.com/', 'handsontable'));
		j.t('<div#example>', '');
		b.l('<script>
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

	procedure datatables is
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[bootstrap.css]');
		j.u('<script>', '[jquery.js]', '');
		j.u('<link rel=stylesheet/>', '[dataTables.bootstrap.css]');
		j.u('<script>', '[jquery.dataTables.js]', '');
		j.u('<script>', '[dataTables.bootstrap.js]', '');
		j.t('<h3.page-header>', j.u('<a target=_blank>', 'datatables', 'http://datatables.net/'));
		j.t('<div.container-fluid>');
	
		j.t('<table.table.table-bordered style=table-layout:fixed>');
		j.t('<colgroup>', m.w('<col width="@0">', '20,15,20,10'));
		j.t('<thead>', j.t('<tr>', m.w('<td>@</td>', 'name,email,phone,salary')));
		j.t('<tbody>');
		for i in (select a.*, rowid rid from employees a) loop
			j.t('<tr>');
			j.t(' <td>', i.first_name || ' ' || i.last_name);
			j.t(' <td>', i.email);
			j.t(' <td>', i.phone_number);
			j.t(' <td>', i.salary);
			j.t('</tr>');
		end loop;
		j.t('</tbody>');
		j.t('</table>');
	
		b.l('<script>
		$(document).ready(function(){
			$("table").DataTable();
		});
		</script>');
	end;

end tables_h;
/
