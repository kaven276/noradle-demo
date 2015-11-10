create or replace package body http_b is

	procedure gzip is
	begin
		case r.getc('use', 'on')
			when 'on' then
				h.content_encoding_try_zip;
			when 'off' then
				h.content_encoding_identity;
			when 'auto' then
				h.content_encoding_auto;
		end case;
	
		src_b.header;
		b.line('This page gzip setting is ' || r.getc('use', 'auto') || '<br/>');
		b.line('This page print ' || r.getc('count', 100) || ' numbers <br/>');
		b.line('<br/>');
	
		b.line('<form action="http_b.gzip">');
		b.line('gzip options: ');
		b.line('<input name="use" type="radio" value="on" checked/>');
		b.line('<label>ON(if support)</label>');
		b.line('<input name="use" type="radio" value="off"/>');
		b.line('<label>OFF</label>');
		b.line('<input name="use" type="radio" value="auto"/>');
		b.line('<label>AUTO(if support and response deserve for zip)</label>');
		b.line('<br/>');
		b.line('how many numbers to print: ');
		b.line('<input name="count" type="text" value="' || r.getc('count', 100) || '">');
		b.line('<br/>');
		b.line('<input type="submit"/>');
		b.line('</form>');
		b.line('<br/>');
	
		for i in 1 .. r.getc('count', 100) loop
			b.line(i || '<br/>');
		end loop;
	end;

	procedure chunked_transfer is
	begin
		h.content_encoding_identity;
		h.header_close;
	
		b.line('<link href="http_b.content_css" type="text/css" rel="stylesheet"/>');
		b.line('<script src="http_b.content_js"></script>');
		src_b.header;
		b.line('This page transfer-encoding setting is ' || r.getc('use', 'on') || '<br/>');
		b.line('This page print ' || r.getc('count', 100) || ' numbers <br/>');
		b.line('<br/>');
	
		b.line('<form action="http_b.chunked_transfer">');
		b.line('flush in half way(chunked transfer) options: ');
		b.line('<input name="use" type="radio" value="on"/>');
		b.line('<label>ON</label>');
		b.line('<input name="use" type="radio" value="off"/>');
		b.line('<label>OFF</label>');
		b.line('<br/>');
		b.line('how many numbers to print: ');
		b.line('<input name="count" type="text" value="' || r.getc('count', 100) || '">');
		b.line('<br/>');
		b.line('<input type="submit"/>');
		b.line('</form>');
		b.line('When this page is print out at this point, it will wait a while for big data processing.<br/>');
		b.line('So it should use "b.flush" API to send the already generated part to client/browser.<br/>');
		b.line(x.e('You call b.flush after <head><script><link> to load referenced files early, before body is generated.<br/>'));
		b.line('Call b.flush will use chunked transfer-encode mode instead of the default Content-Length mode<br/>');
	
		if r.getc('use', 'on') = 'on' then
			b.flush;
		end if;
	
		dbms_lock.sleep(2);
	
		for i in 1 .. r.getc('count', 100) loop
			b.line(i || '<br/>');
		end loop;
	end;

	procedure long_job is
	begin
		b.set_line_break(chr(10));
		h.content_encoding_identity;
		h.header_close;
	
		src_b.header;
		b.line('<h3>This a long-running page that use chunked transfer and flush by section to response early</h3>');
		b.line('<div id="cnt"></div>');
		b.line('<script>var cnt=document.getElementById("cnt");</script>');
		b.line('<pre>');
		for i in 1 .. 9 loop
			b.line('LiNE, NO.' || i);
			b.line('<script>cnt.innerText=' || i || ';</script>');
			-- b.line(rpad(i, 300, i));
			if r.is_lack('inspect') then
				b.flush;
				-- you may not force flush when h.auto_chunk_max_idle is set.
				-- but you can close auto flush by call h.auto_chunk_max_idle(null);
				dbms_lock.sleep(1);
			end if;
		end loop;
		b.line('</pre>');
		b.line('<p>Over, Full page is generated completely</p>');
	end;

	procedure content_type is
		procedure mime_link(mime varchar2) is
		begin
			b.line('<a target="_blank" href="http_b.content_type?mime=' || mime || '"> open ' || mime ||
						 ' edition to new window </a><br/>');
		end;
	begin
		h.content_type(r.getc('mime', 'text/html'));
	
		b.line('<html>');
		b.line('<head>');
	
		if r.getc('mime', 'text/html') = 'text/html' then
			b.line('<link href="http_b.content_css" rel="stylesheet" type="text/css"/>');
			b.line('<script src="http_b.content_js"></script>');
		end if;
	
		b.line('</head>');
		b.line('<body>');
	
		if r.getc('mime', 'text/html') = 'text/html' then
			src_b.header;
			b.line('<br/>');
		
			mime_link('text/html');
			mime_link('text/plain');
			mime_link('text/xml');
		
			mime_link('application/msword');
			mime_link('application/vnd.ms-excel');
			mime_link('application/vnd.ms-powerpoint');
			mime_link('application/octet-stream');
		
			b.line('<a href="http_b.content_css" target="_blank">view linked css (http_b.content_css)</a><br/>');
			b.line('<a href="http_b.content_js" target="_blank">view included js (http_b.content_js)</a><br/>');
		end if;
	
		b.line('<style>a{line-height:1.5em;text-decoration:none;}</style>');
		b.line('<div>');
		b.line('<h1> document header </h1>');
		b.line('<h3>You can use h.content_type API to specify what you output to the http entity body.</h3>');
		b.line('<h3>' || 'This is a ' || r.getc('mime', 'text/html') || ' mime-typed page' || '</h3>');
		b.line('<p>paragraph 1</p>');
		b.line('<p>paragraph 2</p>');
		b.line('<p>paragraph 3</p>');
		b.line('</div>');
		b.line('<table rules="all" style="border:1px solid red;">');
		b.line('<tr><td>A1</td><td>B1</td></tr><tr>');
		b.line('<td>A2</td><td>B2</td></tr>');
		b.line('</table>');
		b.line('</body>');
		b.line('</html>');
	
	end;

	procedure content_css is
	begin
		h.content_type(mime_type => 'text/css');
		h.content_type(h.mime_css);
		b.line('body {background-color:silver;}');
	end;

	procedure content_js is
	begin
		h.content_type(mime_type => 'application/x-javascript');
		b.line('alert("javascript speaking");');
	end;

	procedure refresh is
	begin
		if r.is_lack('inspect') then
			h.refresh(r.getn('interval', 3, '9'), r.getc('to', ''));
		end if;
		src_b.header;
		b.line('<pre>');
		b.line(t.dt2s(sysdate));
		b.line('refresh to ' || r.getc('to', 'self') || ' every ' || r.getn('interval', 3) || 's');
		b.line('</pre>');
	end;

	procedure content_md5 is
	begin
		h.content_md5_on;
		if r.getb('nozip', true) then
			-- md5 is computed in Oracle
			h.content_encoding_identity;
		else
			-- md5 is computed in NodeJS;
			null;
		end if;
		src_b.header;
		x.p('<p>', 'Use http content-md5 header to ensure response body integrity.');
		x.p('<p>', 'Call h.conent_md5_on to automatically compute md5 of response body and set content-md5 header.');
		x.p('<p>', 'Content MD5 for the same page is diffrent for diffrent Content-Encoding');
	end;

end http_b;
/
