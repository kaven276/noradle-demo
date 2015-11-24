create or replace package body basic_io_b is

	function name_pattern(name varchar2) return varchar2 is
	begin
		if substrb(name, 2, 2) = '$$' then
			return substrb(name, 1, 3);
		elsif substrb(name, 2, 1) = '$' then
			return substrb(name, 1, 2);
		elsif substrb(name, 1, 1) = '[' then
			return '[]';
		else
			return '*';
		end if;
	end;

	procedure req_info is
		n     varchar2(100);
		v     varchar2(999);
		va    st;
		sn    varchar2(3) := '';
		topic varchar2(30) := r.getc('topic', '%');
	begin
		b.set_line_break(chr(10));
		src_b.header;
		x.p('<style>', 'hr{margin:2em 0 1em;}');
		b.line('<pre>');
	
		if 'param' like topic then
			b.line('## request parameter that may be got from the following ways');
			b.line('1. query string');
			b.line('2. post with application/x-www-form-urlencoded');
			b.line('3. post with multipart/form-data');
			b.line;
			x.a('<a>', 'get/post form demo', '@b.parameters');
			x.a('<a>', 'post json demo', './post_file_b.ajax_post_json');
			x.a('<a>', 'form multipart/form-data demo', './post_file_b.upload_form');
			b.line;
			n := ra.params.first;
			loop
				exit when n is null;
				if lengthb(n) < 2 or (substrb(n, 2, 1) != '$' and substrb(n, 1, 1) != '[') then
					va := ra.params(n);
					b.line(sn || n || ' : [' || t.join(va, ', ') || ']');
					for i in 1 .. va.count loop
						b.line(sn || '  ' || i || '. ' || r.unescape(va(i)));
					end loop;
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'url' like topic then
			x.t('<hr/>');
			b.line('## basic request info derived from http request line and http header host');
			b.line('');
			b.line('r.method : ' || r.method);
			b.line('r.url : ' || r.url);
			b.line('');
			b.line('r.url_full : ' || r.url_full);
			b.line('r.dir_full : ' || r.dir_full);
			b.line('');
			b.line('r.site : ' || r.site);
			b.line(' r.protocol(false) : ' || r.protocol(false));
			b.line(' r.protocol(true) : ' || r.protocol(true));
			b.line(' r.host : ' || r.host);
			b.line('  r.hostname : ' || r.hostname);
			b.line('   r.sdns : ' || r.sdns);
			b.line('   r.pdns : ' || r.pdns);
			b.line('  r.port : ' || r.port);
			b.line('');
			b.line('r.path : ' || r.path);
			b.line(' r.pathname : ' || r.pathname);
			b.line('  r.dir : ' || r.dir);
			b.line('  r.prog : ' || r.prog);
			b.line('   r.pack : ' || r.pack);
			b.line('   r.proc : ' || r.proc);
			b.line('   r.type : ' || r.type);
			b.line('   r.is_readonly : ' || t.tf(r.is_readonly, 'true', 'false'));
			b.line(' r.subpath : ' || r.subpath);
			b.line(' r.search : ' || r.search);
			b.line(' r.qstr : ' || r.qstr);
		end if;
	
		if 'exec' like topic then
			x.t('<hr/>');
			b.line('## core excution NV');
			b.line;
			b.line('x$dbu|r.dbu : ' || r.dbu);
			b.line('x$prog|r.prog : ' || r.prog);
			b.line('x$before : ' || r.getc('x$before'));
			b.line('x$after : ' || r.getc('x$after'));
		end if;
	
		if 'session' like topic then
			x.t('<hr/>');
			b.line('## session related info');
			b.line;
			x.a('<a>', 'link to protected page who require logged-in session', './auth_b.protected_page');
			b.line('r.bsid : ' || r.bsid);
			b.line('r.msid : ' || r.msid);
			b.line('r.gid : ' || r.gid);
			b.line('r.uid : ' || r.uid);
			b.line('s$ : ' || r.getc('s$'));
			b.line('r.idle : ' || r.idle);
			b.line('r.lat : ' || r.lat);
			n := ra.params.first;
			loop
				exit when n is null;
				if substrb(n, 1, 3) like 's$_' then
					tmp.stv := ra.params(n);
					b.line(sn || n || ' : [' || t.join(tmp.stv, ', ') || ']');
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'link' like topic then
			x.t('<hr/>');
			b.line('## file/link related info');
			b.line;
			b.line('r.file : if static url mapped to lob stored in oracle database other than external filesystem file' ||
						 r.file);
			n := ra.params.first;
			loop
				exit when n is null;
				if n like 'l$%' then
					b.line(sn || n || ' : ' || r.getc(n));
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'charset' like topic then
			x.t('<hr/>');
			b.line('## charset info');
			b.line;
			b.line('## charset related');
			b.line('h.charset : ' || h.charset);
			--b.line('r.req_charset_db : ' || t.tf(r.req_charset_db));
			--b.line('r.req_charset_ndb : ' || t.tf(r.req_charset_ndb));
			--b.line('r.req_charset_utf8 : ' || t.tf(r.req_charset_utf8));
		end if;
	
		if 'infra' like topic then
			x.t('<hr/>');
			b.line('## infrastucture info');
			b.line;
			b.line('r.database_role : ' || r.database_role);
			b.line('r.db_unique_name : ' || r.db_unique_name);
			b.line('r.instance : ' || r.instance);
			b.line('r.cfg : ' || r.cfg);
			b.line('r.slot : ' || r.slot);
			b.line('r.cid|b$cid : ' || r.cid);
			b.line('r.cslot|b$cslot : ' || r.cslot);
		end if;
	
		if 'header2' like topic then
			h.header('etag', '"BASIC_IO_B.V1"');
			h.last_modified((sysdate));
			x.t('<hr/>');
			b.line('## basic request info derived from http header');
			b.line;
			x.a('<a>', 'link to page who require http basic authorization', './auth_b.basic');
			b.line(q'|r.header('authorization') : |' || r.header('authorization'));
			b.line(q'|r.getc('h$authorization') : |' || r.getc('h$authorization'));
			b.line('r.user : ' || r.user);
			b.line('r.pass : ' || r.pass);
			b.line('r.ua : ' || r.ua);
			b.line('r.referer : ' || r.referer);
			b.line('r.referer2 : ' || r.referer2);
			b.line('r.is_xhr : ' || t.tf(r.is_xhr, 'true', 'false'));
			b.line('r.is_readonly : ' || t.tf(r.is_readonly, 'true', 'false'));
			b.line('r.etag : ' || r.etag);
			b.line('r.lmt : ' || r.lmt);
		end if;
	
		if 'addr' like topic then
			x.t('<hr/>');
			b.line('## client/server address from TCP socket or x-forwarded-* headers');
			b.line;
			b.line('r.client_addr(false) : ' || r.client_addr(false));
			b.line('r.client_port(false) : ' || r.client_port(false));
			b.line('r.client_addr(true) : ' || r.client_addr(true));
			b.line('r.client_port(true) : ' || r.client_port(true));
			b.line('r.server_family : ' || r.server_family);
			b.line('r.server_addr : ' || r.server_addr);
			b.line('r.server_port : ' || r.server_port);
		end if;
	
		if 'header' like topic then
			x.t('<hr/>');
			b.line('## original http request headers exclude cookies');
			b.line;
			n := ra.params.first;
			loop
				exit when n is null;
				if n like 'h$%' and n not like 'h$$%' then
					v := ra.params(n) (1);
					b.line(sn || n || ' : ' || v);
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'accept' like topic then
			x.t('<hr/>');
			b.line('## all http request headers parsed to array');
			b.line;
			n := ra.params.first;
			loop
				exit when n is null;
				if substrb(n, 1, 3) = 'h$$' then
					tmp.stv := ra.params(n);
					b.line(sn || n || ' : [' || t.join(tmp.stv, ', ') || ']');
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'cookie' like topic then
			x.t('<hr/>');
			b.line('## This is all http request cookies');
			b.line;
			x.a('<a>', 'link to page who set/view cookies', './cookie_h.form_view');
			n := ra.params.first;
			loop
				exit when n is null;
				if n like 'c$%' then
					v := ra.params(n) (1);
					b.line(sn || n || ' : ' || v);
				end if;
				n := ra.params.next(n);
			end loop;
		end if;
	
		if 'all' like topic then
			x.t('<hr/>');
			b.line('## all request name-value pairs');
			b.line;
			n     := ra.params.first;
			tmp.s := name_pattern(n);
			loop
				exit when n is null;
				va := ra.params(n);
				if va.count = 1 then
					b.line(sn || n || ' : ' || va(1));
				else
					b.line(sn || n || ' : [' || t.join(va, ', ') || ']');
				end if;
				n := ra.params.next(n);
				if name_pattern(n) != tmp.s then
					b.line;
					tmp.s := name_pattern(n);
				end if;
			end loop;
		end if;
	
		b.line('</pre>');
	end;

	procedure output is
	begin
		b.set_line_break(chr(10));
		src_b.header;
		b.line('<pre>');
	
		b.line('Basic output include the following APIs');
		b.line('b.write(text) : write text to http entity content');
		b.line('b.writeln(text) : write text and newline character(s) to http entity content');
		b.line('b.string(text) : write text to http entity content');
		b.line('b.line(text) : write text and newline character(s) to http entity content');
		b.line('b.set_line_break(nlbr) : set the newline break character(s), usually LF,CR,CRLF');
	
		b.line;
		b.write('output by b.write');
		b.writeln('output by b.writeln');
		b.string('output by b.string');
		b.line('output by b.line');
	
		b.line;
		b.line('b.write = b.string, they are just alias each other');
		b.line('b.writeln = b.line, they are just alias each other');
	
		b.line;
		b.line('line break can be set using b.set_line_break()');
		b.set_line_break(chr(10));
		b.line('This is line end with line break chr(10) or LF');
		b.set_line_break(chr(13));
		b.line('This is line end with line break chr(13) or CR');
		b.set_line_break(chr(13) || chr(10));
		b.line('This is line end with line break chr(13)||chr(10) or CRLF');
		b.line('</pre>');
	end;

	procedure parameters is
	begin
		src_b.header;
		x.t('<br/>');
		x.f('<form name=f,method=get>', '@b.req_info?topic=param&p1=1&p2=2');
		x.o(' <select name=mtd>');
		x.p('  <option>', 'get');
		x.p('  <option>', 'post');
		x.c(' </select>');
		x.p(' <script>', 'document.f.mtd.onchange=function(){document.f.method = this.value;};');
		x.v(' <input type=hidden,name=topic>', 'param');
		x.s(' <input type=text,name=p1,value=1>');
		x.s(' <input type=text,name=p1,value=2>');
		x.s(' <input type=submit>');
		x.c('</form>');
		x.t('<br/>');
		x.p('<p>', 'Method get will erase the query string in form.action.');
		x.p('<p>',
				'Method post will keep the query string in form.action but replace the parameter in qstr if there are same named form items.');
	end;

	procedure keep_urlencoded is
	begin
		pc.h;
		src_b.header;
		x.t('<br/>');
		x.f('<form name=f,method=get>', '@b.req_info');
		x.o(' <select name=mtd>');
		x.p('  <option>', 'get');
		x.p('  <option>', 'post');
		x.c(' </select>');
		x.p(' <script>', 'document.f.mtd.onchange=function(){document.f.method = this.value;};');
		x.s(' <input type=hidden,name=topic,value=param>');
		x.v(' <input type=text,name=_qstr1>', nvl(r.qstr, 'a=1&b=2'));
		x.v(' <input type=text,name=_qstr2>', nvl(r.qstr, 'a=3&b=4'));
		x.s(' <input type=text,name=p1,value=1>');
		x.s(' <input type=text,name=p1,value=2>');
		x.s(' <input type=submit>');
		x.c('</form>');
	end;

	procedure steps is
		no pls_integer := r.getn('step_no', 0) + 1;
		n  varchar2(100);
	begin
		src_b.header;
		x.p('<h3>', 'already filled items');
		n := ra.params.first;
		loop
			exit when n is null;
			if substrb(n, 2, 1) = '$' then
				null;
			else
				x.p('<p>', n || ' : ' || r.dump(n, true));
			end if;
			n := ra.params.next(n);
		end loop;
		x.t('<hr/>');
		if r.is_lack('commit') then
			-- delete from params, so not keep step_no to next step
			r.del('step_no');
			x.f('<form method=post>', r.prog);
			x.v(' <input readonly type=text,name=_saves>', r.vqstr);
			x.t(' <br/>');
			x.v(' <input readonly type=text,name=step_no>', no);
			x.s(' <input type=text,name=p:1,value=1>', st(no));
			x.s(' <input type=submit,value=next>');
			x.s(' <input type=submit,name=commit,value=commit>');
			x.c('</form>');
		else
			x.p('<h3>', 'all steps complete, commit all collected infomation ok!');
		end if;
	end;

	procedure any_size is
		v_size  number(8) := r.getn('size', 0);
		v_chunk varchar2(1024) := rpad('H', 1024, '.');
	begin
		k_debug.set_run_comment('size:' || v_size);
		h.content_encoding_identity;
		src_b.header;
		for i in 1 .. v_size loop
			b.write(v_chunk);
		end loop;
	end;

	procedure appended is
		v_pattern varchar2(100) := upper(r.getc('name')) || '%';
	begin
		src_b.header;
		b.line('<h1>object list prefixed with param "name"="' || v_pattern || '"</h1>');
		b.save_pointer;
		for i in (select *
								from user_objects a
							 where a.object_name like v_pattern
								 and rownum <= 3) loop
			b.line('<p>' || i.object_name || ' - ' || i.object_type || '</p>');
		end loop;
		if b.not_appended then
			b.line('<h4>no objects found by ' || v_pattern || '</h4>');
		end if;
	end;

end basic_io_b;
/
