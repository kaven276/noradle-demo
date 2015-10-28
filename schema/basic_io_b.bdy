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
		n  varchar2(100);
		v  varchar2(999);
		va st;
		sn varchar2(3) := '';
	begin
		h.set_line_break(chr(10));
		src_b.link_proc;
		x.p('<style>', 'hr{margin:2em 0 1em;}');
		h.line('<pre>');
	
		h.line('## basic request info derived from http request line and http header host');
		h.line('');
		h.line('r.method : ' || r.method);
		h.line('r.url : ' || r.url);
		h.line('');
		h.line('r.url_full : ' || r.url_full);
		h.line('r.dir_full : ' || r.dir_full);
		h.line('');
		h.line('r.site : ' || r.site);
		h.line(' r.protocol(false) : ' || r.protocol(false));
		h.line(' r.protocol(true) : ' || r.protocol(true));
		h.line(' r.host : ' || r.host);
		h.line('  r.hostname : ' || r.hostname);
		h.line('   r.sdns : ' || r.sdns);
		h.line('   r.pdns : ' || r.pdns);
		h.line('  r.port : ' || r.port);
		h.line('');
		h.line('r.path : ' || r.path);
		h.line(' r.pathname : ' || r.pathname);
		h.line('  r.dir : ' || r.dir);
		h.line('  r.prog : ' || r.prog);
		h.line('   r.pack : ' || r.pack);
		h.line('   r.proc : ' || r.proc);
		h.line('   r.type : ' || r.type);
		h.line('   r.is_readonly : ' || t.tf(r.is_readonly, 'true', 'false'));
		h.line(' r.subpath : ' || r.subpath);
		h.line(' r.search : ' || r.search);
		h.line(' r.qstr : ' || r.qstr);
	
		x.t('<hr/>');
		h.line('## core excution NV');
		h.line;
		h.line('x$dbu|r.dbu : ' || r.dbu);
		h.line('x$prog|r.prog : ' || r.prog);
		h.line('x$before : ' || r.getc('x$before'));
		h.line('x$after : ' || r.getc('x$after'));
	
		x.t('<hr/>');
		h.line('## session related info');
		h.line;
		x.a('<a>', 'link to protected page who require logged-in session', './auth_b.protected_page');
		h.line('r.bsid : ' || r.bsid);
		h.line('r.msid : ' || r.msid);
		h.line('r.gid : ' || r.gid);
		h.line('r.uid : ' || r.uid);
		h.line('s$ : ' || r.getc('s$'));
		h.line('r.idle : ' || r.idle);
		h.line('r.lat : ' || r.lat);
		n := ra.params.first;
		loop
			exit when n is null;
			if substrb(n, 1, 3) like 's$_' then
				tmp.stv := ra.params(n);
				h.line(sn || n || ' : [' || t.join(tmp.stv, ', ') || ']');
			end if;
			n := ra.params.next(n);
		end loop;
	
		x.t('<hr/>');
		h.line('## file/link related info');
		h.line;
		h.line('r.file : if static url mapped to lob stored in oracle database other than external filesystem file' ||
					 r.file);
		n := ra.params.first;
		loop
			exit when n is null;
			if n like 'l$%' then
				h.line(sn || n || ' : ' || r.getc(n));
			end if;
			n := ra.params.next(n);
		end loop;
	
		/*
    h.line;
    h.line('## charset related');
    h.line('r.req_charset_db : ' || t.tf(r.req_charset_db));
    h.line('r.req_charset_ndb : ' || t.tf(r.req_charset_ndb));
    h.line('r.req_charset_utf8 : ' || t.tf(r.req_charset_utf8));
    */
	
		x.t('<hr/>');
		h.line('## infrastucture info');
		h.line;
		h.line('r.database_role : ' || r.database_role);
		h.line('r.db_unique_name : ' || r.db_unique_name);
		h.line('r.instance : ' || r.instance);
		h.line('r.cfg : ' || r.cfg);
		h.line('r.slot : ' || r.slot);
		h.line('r.cid|b$cid : ' || r.cid);
		h.line('r.cslot|b$cslot : ' || r.cslot);
	
		h.header('etag', '"BASIC_IO_B.V1"');
		h.last_modified((sysdate));
		x.t('<hr/>');
		h.line('## basic request info derived from http header');
		h.line;
		x.a('<a>', 'link to page who require http basic authorization', './auth_b.basic');
		h.line(q'|r.header('authorization') : |' || r.header('authorization'));
		h.line(q'|r.getc('h$authorization') : |' || r.getc('h$authorization'));
		h.line('r.user : ' || r.user);
		h.line('r.pass : ' || r.pass);
		h.line('r.ua : ' || r.ua);
		h.line('r.referer : ' || r.referer);
		h.line('r.referer2 : ' || r.referer2);
		h.line('r.is_xhr : ' || t.tf(r.is_xhr, 'true', 'false'));
		h.line('r.is_readonly : ' || t.tf(r.is_readonly, 'true', 'false'));
		h.line('r.etag : ' || r.etag);
		h.line('r.lmt : ' || r.lmt);
	
		x.t('<hr/>');
		h.line('## client/server address from TCP socket or x-forwarded-* headers');
		h.line;
		h.line('r.client_addr(false) : ' || r.client_addr(false));
		h.line('r.client_port(false) : ' || r.client_port(false));
		h.line('r.client_addr(true) : ' || r.client_addr(true));
		h.line('r.client_port(true) : ' || r.client_port(true));
		h.line('r.server_family : ' || r.server_family);
		h.line('r.server_addr : ' || r.server_addr);
		h.line('r.server_port : ' || r.server_port);
	
		x.t('<hr/>');
		h.line('## original http request headers exclude cookies');
		h.line;
		n := ra.params.first;
		loop
			exit when n is null;
			if n like 'h$%' and n not like 'h$$%' then
				v := ra.params(n) (1);
				h.line(sn || n || ' : ' || v);
			end if;
			n := ra.params.next(n);
		end loop;
	
		x.t('<hr/>');
		h.line('## all http request headers parsed to array');
		h.line;
		n := ra.params.first;
		loop
			exit when n is null;
			if substrb(n, 1, 3) = 'h$$' then
				tmp.stv := ra.params(n);
				h.line(sn || n || ' : [' || t.join(tmp.stv, ', ') || ']');
			end if;
			n := ra.params.next(n);
		end loop;
	
		x.t('<hr/>');
		h.line('## This is all http request cookies');
		h.line;
		x.a('<a>', 'link to page who set/view cookies', './cookie_h.form_view');
		n := ra.params.first;
		loop
			exit when n is null;
			if n like 'c$%' then
				v := ra.params(n) (1);
				h.line(sn || n || ' : ' || v);
			end if;
			n := ra.params.next(n);
		end loop;
	
		x.t('<hr/>');
		h.line;
		h.line('## request parameter that may be got from the following ways');
		h.line('1. query string');
		h.line('2. post with application/x-www-form-urlencoded');
		h.line('3. post with multipart/form-data');
		h.line;
		n := ra.params.first;
		loop
			exit when n is null;
			if lengthb(n) < 2 or (substrb(n, 2, 1) != '$' and substrb(n, 1, 1) != '[') then
				va := ra.params(n);
				h.line(sn || n || ' : ' || t.join(va, ', '));
				for i in 1 .. va.count loop
					h.line(sn || '  ' || i || '. ' || r.unescape(va(i)));
				end loop;
			end if;
			n := ra.params.next(n);
		end loop;
	
		x.t('<hr/>');
		h.line('## all request name-value pairs');
		h.line;
		n     := ra.params.first;
		tmp.s := name_pattern(n);
		loop
			exit when n is null;
			va := ra.params(n);
			if va.count = 1 then
				h.line(sn || n || ' : ' || va(1));
			else
				h.line(sn || n || ' : [' || t.join(va, ', ') || ']');
			end if;
			n := ra.params.next(n);
			if name_pattern(n) != tmp.s then
				h.line;
				tmp.s := name_pattern(n);
			end if;
		end loop;
	
		h.line('</pre>');
	end;

	procedure output is
	begin
		h.set_line_break(chr(10));
		src_b.link_proc;
		h.line('<pre>');
	
		h.line('Basic output include the following APIs');
		h.line('h.write(text) : write text to http entity content');
		h.line('h.writeln(text) : write text and newline character(s) to http entity content');
		h.line('h.string(text) : write text to http entity content');
		h.line('h.line(text) : write text and newline character(s) to http entity content');
		h.line('h.set_line_break(nlbr) : set the newline break character(s), usually LF,CR,CRLF');
	
		h.line;
		h.write('output by h.write');
		h.writeln('output by h.writeln');
		h.string('output by h.string');
		h.line('output by h.line');
	
		h.line;
		h.line('h.write = h.string, they are just alias each other');
		h.line('h.writeln = h.line, they are just alias each other');
	
		h.line;
		h.line('line break can be set using h.set_line_break()');
		h.set_line_break(chr(10));
		h.line('This is line end with line break chr(10) or LF');
		h.set_line_break(chr(13));
		h.line('This is line end with line break chr(13) or CR');
		h.set_line_break(chr(13) || chr(10));
		h.line('This is line end with line break chr(13)||chr(10) or CRLF');
		h.line('</pre>');
	end;

	procedure parameters is
		v pls_integer := r.getn('step_no', 1);
	begin
		pc.h;
		src_b.link_proc;
		x.t('<br/>');
		x.o('<form name=f,method=get,action=:1>', st(l('@b.req_info?qstr1=A&qstr1=B&p1=0')));
		x.o(' <select name=mtd>');
		x.p('  <option>', 'get');
		x.p('  <option>', 'post');
		x.c(' </select>');
		x.p(' <script>', 'document.f.mtd.onchange=function(){document.f.method = this.value;};');
		x.v(' <input type=hidden>', v);
		x.s(' <input type=text,name=p:1,value=1>', st(v));
		x.s(' <input type=text,name=p:1,value=2>', st(v));
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
		src_b.link_proc;
		x.t('<br/>');
		x.o('<form name=f,method=get,action=:1>', st(l('@b.req_info')));
		x.o(' <select name=mtd>');
		x.p('  <option>', 'get');
		x.p('  <option>', 'post');
		x.c(' </select>');
		x.p(' <script>', 'document.f.mtd.onchange=function(){document.f.method = this.value;};');
		x.v(' <input type=text,name=_qstr1>', nvl(r.qstr, 'a=1&b=2'));
		x.v(' <input type=text,name=_qstr2>', nvl(r.qstr, 'a=3&b=4'));
		x.s(' <input type=text,name=p1,value=1>');
		x.s(' <input type=text,name=p1,value=2>');
		x.s(' <input type=submit>');
		x.c('</form>');
	end;

	procedure any_size is
		v_size  number(8) := r.getn('size', 0);
		v_chunk varchar2(1024) := rpad('H', 1024, '.');
	begin
		k_debug.set_run_comment('size:' || v_size);
		h.content_encoding_identity;
		for i in 1 .. v_size loop
			h.write(v_chunk);
		end loop;
	end;

end basic_io_b;
/
