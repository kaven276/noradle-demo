create or replace package body purecss_b is

	procedure d is
		procedure tables is
		begin
			j.t('<table.pure-table.pure-table-horizontal>');
			j.t('<thead>');
			j.t(' <tr>');
			j.t('  <th>', 'country_id');
			j.t('  <th>', 'country_name');
			j.t(' </tr>');
			j.t('</thead>');
			j.t('<tbody>');
			for i in (select * from countries a) loop
				j.t('<tr>');
				j.t(' <td>', i.country_id);
				j.t(' <td>', i.country_name);
				j.t('</tr>');
			end loop;
			j.t('</tbody>');
			j.t('</table>');
		end;
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[pure.css]');
		j.t('<h2>', j.u('<a target=_blank>', 'http://purecss.io/', 'purecss official site'));
		tables;
	end;

end purecss_b;
/
