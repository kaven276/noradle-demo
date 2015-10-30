create or replace package body test_b is

	procedure entry is
	begin
		h.header_close;
		b.line('<pre>');
		b.line('<a href="test_b.d">Link to test_b.d (basic request info) </a>');
		b.line('<a href="test_b.redirect">Link to test_b.redirect (test for redirect)</a>');
		b.line('</pre>');
		b.line(r.protocol);
		b.line(r.client_addr);
		b.line(r.client_port);
		b.line(r.header('x-forwarded-proto'));
		b.line(r.header('x-forwarded-for'));
		b.line(r.header('x-forwarded-port'));
	end;

	procedure d is
	begin
		if r.getn('count', 0) = 404 then
			h.sts_404_not_found;
			h.header_close;
			b.writeln('resource with count=404 does not exits');
			g.cancel;
		end if;
	
		if r.getn('count', 0) = 403 then
			h.sts_403_forbidden;
			h.header_close;
			b.writeln('You have not the right to access resource with count=403');
			g.cancel;
		end if;
	
		-- h.allow_post;
		-- h.allow('POST,PUT');
		h.sts_200_ok;
		h.content_type('text/html', charset => 'utf-8');
		h.content_language('zh-cn');
		h.set_cookie('bsid', 'myself', path => r.dir || 'test_b.d');
	
		h.header('a', 1);
		h.header_close;
	
		pc.h;
		x.o('<style>');
		b.line('p{line-height:1.1em;margin:0px;}');
		x.c('</style>');
		x.p('<p>', 'test case that none ascii charset following http header');
		x.p('<p>', r.hostname);
		x.p('<p>', r.port);
		x.p('<p>', r.method);
		x.p('<p>', r.prog);
		x.p('<p>', r.pack);
		x.p('<p>', r.proc);
		x.p('<p>', r.qstr);
	
		b.line('<br/>');
		b.line(r.header('accept-encoding'));
		b.line('<br/>');
		-- b.line(to_char(r.lmt, 'yyyy-mm-dd hh24:mi:ss'));
		b.line('<br/>');
		-- b.line(r.etag);
		x.t('<br/>');
		x.a('<a>', 'self', r.prog || r.qstr);
	
		for i in 1 .. r.getn('count', 10) loop
			x.p('<p>', i);
		end loop;
	end;

	procedure form is
	begin
		h.content_type(charset => 'gbk');
		h.header_close;
	
		b.line('<a href="test_b.redirect">Link to test_b.redirect</a>');
		b.line('<form action="test_c.do?type=both&type=bothtoo" method="post" accept-charset="gbk">');
		b.line('<input name="text_input" type="text" value="http://www.google.com?q=HELLO"/>');
		b.line('Hello');
		b.line(utl_i18n.escape_reference('Hello', 'us7ascii'));
		b.flush;
		b.line('<input name="checkbox_input" type="checkbox" value="checkedvalue1" checked="true"/>');
		b.line('<input name="checkbox_input" type="checkbox" value="checkedvalue2" checked="true"/>');
		b.line('<input name="password_input" type="password" value="passwordvalue"/>');
		b.line('<input name="button1" type="submit" value="save"/>');
		b.line('</form>');
	end;

	procedure redirect is
		v_st st;
	begin
		case r.method
			when 'POST' then
				h.go('@b.d');
				-- h.feedback;
				return;
			
				h.status_line(200);
				h.content_type(mime_type => 'text/plain', charset => 'gbk');
				h.header_close;
			
				b.line(r.getc('text_input'));
				b.line(r.getc('checkbox_input'));
				r.gets('checkbox_input', v_st);
				for i in 1 .. v_st.count loop
					b.line(v_st(i));
				end loop;
				b.line(r.getc('password_input'));
				b.line(r.getc('button1'));
				b.line(r.getc('type'));
				b.line(r.gets('type') (2));
			
				b.line('');
				b.line('http headers');
				b.line(r.header('accept'));
				b.line(r.header('accept-charset'));
				b.line(r.header('accept-encoding'));
				b.line(r.header('accept-language'));
				b.line(r.header('connection'));
			
				b.line('');
				b.line('cookies');
				b.line(r.cookie('ck1'));
				b.line(r.cookie('ck2'));
				b.line(r.cookie('ck3'));
				b.line(r.cookie('ck4'));
			when 'GET' then
				h.status_line(303);
				h.location('@b.entry');
				h.header_close;
			else
				h.status_line(200);
				h.content_type;
				h.header_close;
				b.line('Method (' || r.method || ') is not supported');
		end case;
	end;

end test_b;
/
