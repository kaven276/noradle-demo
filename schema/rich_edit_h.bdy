create or replace package body rich_edit_h is

	procedure d is
	begin
		src_b.header;
		o.u('<script>', '[jquery.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://yabwe.github.io/medium-editor/', 'medium-editor official site'));
	end;

end rich_edit_h;
/
