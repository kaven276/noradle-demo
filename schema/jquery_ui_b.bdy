create or replace package body jquery_ui_b is

	procedure d is
		procedure date_picker is
		begin
			o.t('<input#date type=text name=date/>');
			o.t('<script>', '$("#date").datepicker();');
		end;
		procedure countries_by_region is
		begin
			o.t('<style>', 'table{width:100%}');
			o.t('<div#accordion>');
			for i in (select a.* from regions a order by a.region_id asc) loop
				o.t('<h3>', i.region_name);
				o.t('<table>');
				for k in (select a.* from countries a where a.region_id = i.region_id order by a.country_name asc) loop
					o.t('<tr>');
					o.t(' <td>', k.country_id);
					o.t(' <td>', k.country_name);
					o.t('</tr>');
				end loop;
				o.t('</table>');
			end loop;
			o.t('</div>');
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
		o.u('<link rel=stylesheet/>', '[jquery-ui.css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[jquery-ui.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://jqueryui.com/', 'jquery-ui official site'));
		date_picker;
		countries_by_region;
	end;

end jquery_ui_b;
/
