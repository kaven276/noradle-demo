create or replace package body cookie_h is

	procedure form_view is
		n varchar2(100);
		v varchar2(999);
	begin
		if not r.is_null('name') then
			h.set_cookie(r.getc('name'), r.getc('value'));
			r.setc('c$' || r.getc('name'), r.getc('value'));
		end if;
		x.o('<form action=./cookie_h.form_view>');
		x.s(' <input type=text,name=name>');
		x.s(' <input type=text,name=value>');
		x.s(' <input type=submit>');
		x.c('</form>');
		x.t('<hr/>');
		x.p('<h4>', '## This is all http request cookies');
		x.o('<ol>');
		n := ra.params.first;
		loop
			exit when n is null;
			if n like 'c$%' then
				v := ra.params(n) (1);
				x.p('<li>', n || ' : ' || v);
			end if;
			n := ra.params.next(n);
		end loop;
		x.c('</ol>');
	end;

end cookie_h;
/
