create or replace package body jquery_ui_b is

	procedure d is
		procedure date_picker is
		begin
			j.t('<input#date type=text name=date/>');
			j.t('<script>', '$("#date").datepicker();');
		end;
		procedure countries_by_region is
		begin
			j.t('<style>', 'table{width:100%}');
			j.t('<div#accordion>');
			for i in (select a.* from regions a order by a.region_id asc) loop
				j.t('<h3>', i.region_name);
				j.t('<table>');
				for k in (select a.* from countries a where a.region_id = i.region_id order by a.country_name asc) loop
					j.t('<tr>');
					j.t(' <td>', k.country_id);
					j.t(' <td>', k.country_name);
					j.t('</tr>');
				end loop;
				j.t('</table>');
			end loop;
			j.t('</div>');
			b.l('<script>
			$(function() {
				$("#accordion").accordion({
					heightStyle: "fill"
				});
			});
			</script>');
		end;
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[jquery-ui.css]');
		j.u('<script>', '[jquery.js]', '');
		j.u('<script>', '[jquery-ui.js]', '');
		j.t('<h2>', j.u('<a target=_blank>', 'http://jqueryui.com/', 'jquery-ui official site'));
		date_picker;
		countries_by_region;
	end;

end jquery_ui_b;
/
