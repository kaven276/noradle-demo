create or replace package body purecss_b is

	procedure d is
		procedure tables is
		begin
			o.t('<table.pure-table.pure-table-horizontal>');
			o.t('<thead>');
			o.t(' <tr>');
			o.t('  <th>', 'country_id');
			o.t('  <th>', 'country_name');
			o.t(' </tr>');
			o.t('</thead>');
			o.t('<tbody>');
			for i in (select * from countries a) loop
				o.t('<tr>');
				o.t(' <td>', i.country_id);
				o.t(' <td>', i.country_name);
				o.t('</tr>');
			end loop;
			o.t('</tbody>');
			o.t('</table>');
		end;
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[pure.css]');
		o.t('<h2>', o.u('<a target=_blank>', 'http://purecss.io/', 'purecss official site'));
		tables;
	end;

end purecss_b;
/
