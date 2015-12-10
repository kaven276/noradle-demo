create or replace package body pjax_h is

	procedure d is
	begin
		src_b.header;
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[pjax.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://pjax.herokuapp.com/', 'pjax official site'));
	end;

end pjax_h;
/
