create or replace package body post_file_b is

	procedure upload_form is
	begin
		h.allow('GET,POST');
		h.status_line(200);
		h.header_close;
	
		pc.h;
		src_b.link_proc;
		x.p('<p>', 'use form item with name as "_name" to set "name" file upload save dir(relative to upload root)');
		x.p('<p>', 'file: ' || r.getc('file', 'no upload file for "file"'));
		begin
			r.gets('file', tmp.stv);
			tmp.cnt := r.cnt('file');
			for i in 1 .. tmp.cnt loop
				x.p('<p>', 'file[' || i || ']: ' || tmp.stv(i) || ', size ' || r.getc('file.size', 0, i));
			end loop;
		exception
			when others then
				null;
		end;
		x.p('<p>', 'file2: ' || r.getc('file2', 'no upload file for "file2"') || ', size ' || r.getc('file2.size', 0));
		x.p('<p>', 'file3: ' || r.getc('file3', 'no upload file for "file3"') || ', size ' || r.getc('file3.size', 0));
		x.o('<fieldset>');
		x.p(' <legend>', 'form example');
		x.o(' <form name=f,action=post_file_b.upload_form,target=_self,method=post,enctype=multipart/form-data>');
		x.p('  <label>', 'your name' || x.v('<input type=text,name=name>', r.getc('name')));
		x.p('  <label>', 'your password' || x.v('<input type=password,name=pass>', r.getc('pass')));
		x.t('  <br/>');
		x.s('  <input type=hidden,name=_file,value=test/>');
		x.t('  <br/>single');
		x.s('  <input type=file,name=file,size=30,height=5>');
		x.t('  <br/>multiple');
		x.s('  <input multiple type=file,name=file,size=30,height=5>');
		x.t('  <br/>image');
		x.s('  <input type=hidden,name=_file2,value=test2/specified/>');
		x.s('  <input capture type=file,accept=image/*,name=file2,size=30,height=5>');
		x.t('  <br/>video');
		x.s('  <input type=file,accept=video/*,name=file3,size=30,height=5>');
		x.t('  <br/>');
		x.s('  <input type=submit>');
		x.c('</form>');
		x.c('</fieldset>');
		x.p('<canvas>', '');
		x.j('<script>', '*.js');
	end;

	procedure ajax_post is
	begin
		pc.h;
		src_b.link_proc;
		src_b.link_pack;
		x.p('<script>',
				'
var xhr = new XMLHttpRequest();
xhr.open("POST","post_file_b.echo_http_body");
xhr.onreadystatechange = function() {
	if(xhr.readyState != 4 ) return;
	if(xhr.status != 200) return;
	document.getElementById("content").innerHTML = xhr.responseText;
}
xhr.send("<p>abedefg</p>\n\
<p>hijklmn</p>\n\
<p>opq rst</p>\n\
<p>uvw xyz</p>");
');
		x.p('<div#content>', '');
	end;

	procedure echo_http_body is
		v_line  varchar2(200);
		v_nline nvarchar2(200);
	begin
		h.allow('POST');
		h.content_type('text/plain');
		x.p('<h3>', 'ajax request meta info');
		x.p('<p>', 'r.method: ' || r.method);
		x.p('<p>', 'content-type: ' || r.header('content-type'));
		x.p('<p>', 'content-length: ' || r.header('content-length'));
		x.p('<p>', 'x-requested-with: ' || r.header('x-requested-with'));
		x.p('<p>', 'origin: ' || r.header('origin'));
		x.p('<p>', 'is_xhr: ' || t.tf(r.is_xhr, 'true', 'false'));
		x.p('<p>', 'rb.mime_type: ' || rb.mime_type);
		x.p('<p>', 'rb.mime_type(major): ' || t.left(rb.mime_type));
		x.p('<p>', 'rb.mime_type(minor): ' || t.right(rb.mime_type));
		x.p('<p>', 'rb.charset_http: ' || rb.charset_http);
		x.p('<p>', 'rb.charset_db: ' || rb.charset_db);
		x.p('<p>', 'rb.length: ' || rb.length);
		x.p('<p>', 'length(rb.blob_entity): ' || dbms_lob.getlength(rb.blob_entity));
		r.body2clob;
		x.p('<p>', 'length(rb.clob_entity): ' || dbms_lob.getlength(rb.clob_entity));
		x.t('<hr/>');
		x.p('<h3>', 'ajax request request entity content');
		b.write(rb.clob_entity);
	end;

end post_file_b;
/
