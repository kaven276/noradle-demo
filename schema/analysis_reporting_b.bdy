create or replace package body analysis_reporting_b is

	procedure d is
	begin
		src_b.header;
		o.u('<script>', '[jquery.js]', '');
		o.t('<h2>',
				o.u('<a target=_blank>',
						'https://docs.oracle.com/database/121/DWHSG/analysis.htm#i1007779',
						'SQL for Analysis and Reporting'));
	end;

end analysis_reporting_b;
/
