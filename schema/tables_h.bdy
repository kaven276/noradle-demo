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
		o.u('<link rel=stylesheet/>', '[bootstrap.css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[bootstrap.js]', '');
		o.u('<link rel=stylesheet/>', '[bootstrap-editable.css]');
		o.u('<script>', '[bootstrap-editable.js]', '');
		o.t('<script>', t.fill('$.fn.editable.defaults.mode = "@";', r.getc('mode', 'inline')));
		o.t('<style>',
				'.name{width:10em;}
				 .pass{width:10em;}
		     table{table-layout:fixed}
				 td{padding:3px;}');
		o.t('<div.container-fluid>');
		o.t('<h3.page-header>', o.u('<a target=_blank>', 'http://vitalets.github.io/x-editable/', 'x-editable'));
		o.t('<table.table.table-bordered>');
		for i in (select a.*, rowid rid from user_t a) loop
			o.p(1, i.rid);
			o.t('<tr>');
			o.t(' <td.name -name=name -pk=?>', i.name);
			o.t(' <td.pass -name=pass -pk=?>', i.pass);
			o.t('</tr>');
		end loop;
		o.t('</table>');
	
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
		o.u('<script>', '[jquery.js]', '');
		o.u('<link rel=stylesheet/>', '[jquery.handsontable.full.css]');
		o.u('<script>', '[jquery.handsontable.full.js]', '');
		o.t('<h3.page-header>', o.u('<a target=_blank>', 'http://handsontable.com/', 'handsontable'));
		o.t('<div#example>', '');
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
		o.u('<link rel=stylesheet/>', '[bootstrap.css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<link rel=stylesheet/>', '[dataTables.bootstrap.css]');
		o.u('<script>', '[jquery.dataTables.js]', '');
		o.u('<script>', '[dataTables.bootstrap.js]', '');
		o.t('<h3.page-header>', o.u('<a target=_blank>', 'datatables', 'http://datatables.net/'));
		o.t('<div.container-fluid>');
	
		o.t('<table.table.table-bordered style=table-layout:fixed>');
		o.t('<colgroup>', m.w('<col width="@0">', '20,15,20,10'));
		o.t('<thead>', o.t('<tr>', m.w('<td>@</td>', 'name,email,phone,salary')));
		o.t('<tbody>');
		for i in (select a.*, rowid rid from employees a) loop
			o.t('<tr>');
			o.t(' <td>', i.first_name || ' ' || i.last_name);
			o.t(' <td>', i.email);
			o.t(' <td>', i.phone_number);
			o.t(' <td>', i.salary);
			o.t('</tr>');
		end loop;
		o.t('</tbody>');
		o.t('</table>');
	
		b.l('<script>
		$(document).ready(function(){
			$("table").DataTable();
		});
		</script>');
	end;

end tables_h;
/
