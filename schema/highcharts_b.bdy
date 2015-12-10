create or replace package body highcharts_b is

	procedure d is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[hightcharts .css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[highcharts.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://www.highcharts.com/', 'hightcharts 3 official site'));
	
	end;

end highcharts_b;
/
