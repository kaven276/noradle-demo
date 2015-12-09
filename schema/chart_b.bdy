create or replace package body chart_b is

	procedure common_preface(default_type varchar2) is
		v_chart_type varchar2(30) := r.getc('chart_type', default_type);
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[animate.css]');
		o.u('<script>', '[chart.js]', '');
		o.u('<script>', '[zepto.js]', '');
		o.u('<script>', '[underscore.js]', '');
		o.t('<canvas#cc width=600 height=400>', '');
		o.t('<script>',
				t.ps('
		var ctx = document.getElementById("cc").getContext("2d")
		 , demoChart = new Chart(ctx)
		 , chartType=":1"
		 ;',
						 st(v_chart_type)));
	end;

	procedure salary_min_max_by_job_id is
		cur sys_refcursor;
	begin
		if r.is_xhr then
			open cur for
				select a.job_id, count(*) cnt, avg(a.salary) avg, min(a.salary) min, max(a.salary) max
					from employees a
				 group by a.job_id
				 order by avg asc;
			rs.print(cur);
			return;
		end if;
	
		common_preface('Bar');
		o.t('<div#links>');
		o.u(' <a>', r.prog || '?chart_type=Line', 'Line');
		o.u(' <a>', r.prog || '?chart_type=Bar', 'Bar');
		o.u(' <a>', r.prog || '?chart_type=Radar', 'Rader');
		o.t('</div>');
		b.l('<script>
		$.getJSON(location.pathname+"?data", function(data){
			var salaries = data.$DATA.rows;
			var chartData = {
				labels : _.pluck(salaries, "job_id"),
				datasets : [
					{
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,1)",
						pointColor : "rgba(220,220,220,1)",
						pointStrokeColor : "#fff",
						data : _.pluck(salaries, "min")
					},
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						pointColor : "rgba(151,187,205,1)",
						pointStrokeColor : "#fff",
						data : _.pluck(salaries, "max")
					}
				]
			};
			demoChart[chartType](chartData);
		});</script>');
	end;

	procedure salary_share_by_job_id is
		cur sys_refcursor;
	begin
		if r.is_xhr then
			open cur for
				select a.job_id, sum(a.salary) total from employees a group by a.job_id order by total asc;
			rs.print(cur);
			return;
		end if;
	
		common_preface('Pie');
		o.t('<div#links>');
		o.u(' <a>', r.prog || '?chart_type=Pie', 'Pie');
		o.u(' <a>', r.prog || '?chart_type=PolarArea', 'PolarArea');
		o.u(' <a>', r.prog || '?chart_type=Doughnut', 'Doughnut');
		o.t('</div>');
		b.l('<script>
		$.getJSON(location.pathname+"?data", function(data){
			var chartData = data.$DATA.rows.map(function(v,i){
			  return {
				  value : v.total,
					color : "#"+Math.floor(Math.random() * 256*256*256).toString(16).toUpperCase()
				};
			});
			demoChart[chartType](chartData);
		});</script>');
	end;
end chart_b;
/
