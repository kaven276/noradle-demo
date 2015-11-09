create or replace package body layout_b is

	procedure form is
		v_dir varchar2(1) := r.getc('dir', 'H');
		procedure pad(pos pls_integer) is
		begin
			case v_dir
				when 'H' then
					case pos
						when 1 then
							x.t('<tr><th>');
						when 2 then
							x.t('</th><td>');
						when 3 then
							x.t('</td></tr>');
					end case;
				when 'V' then
					case pos
						when 1 then
							x.t('<tr><th>');
						when 2 then
							x.t('</th></tr><tr><td>');
						when 3 then
							x.t('</td></tr>');
					end case;
			end case;
		end;
	begin
		x.o('<html>');
		x.o('<head>');
		x.p('<style>', 'table{border:1px solid}td,th{padding:5px;}');
		x.c('</head>');
		x.o('<body>');
		src_b.link_proc;
		if v_dir = 'H' then
			x.a('<a>', 'change to vertical layout', '@b.form?dir=V');
		else
			x.a('<a>', 'change to horizonal layout', '@b.form?dir=H');
		end if;
		x.o('<form>');
		x.o('<table rules=all>');
		for i in 1 .. 5 loop
			pad(1);
			x.p('<label>', 'name');
			pad(2);
			x.s('<input type=text>');
			pad(3);
		end loop;
		x.c('</table>');
		x.c('</form>');
	end;

	procedure reorder is
	begin
		x.o('<html>');
		x.o('<head>');
		x.o('<script#header type=text>');
		x.p(' <p>', 'header');
		x.c('</script>');
		x.o('<script#footer type=text>');
		x.p(' <p>', 'footer');
		x.c('</script>');
		x.c('</head>');
		x.o('<body>');
		src_b.header;
		x.p('<div#c1>', '');
		x.t('<hr/>');
		x.p('<p>', 'main content here');
		x.p('<p>', 'component html content printed in head as script(type=text)');
		x.p('<p>', 'use js to fill the component content into anchar tags');
		x.p('<p>', 'reorder parts of page in client is easy');
		x.p('<p>', 'so noradle does''t support reorder at server side');
		x.t('<hr/>');
		x.p('<div#c2>', '');
		x.c('</body>');
		x.p('<script>', 'document.getElementById("c1").innerHTML =document.getElementById("header").innerHTML;');
		x.p('<script>', 'document.getElementById("c2").innerHTML =document.getElementById("footer").innerHTML;');
		x.c('</html>');
	end;

end layout_b;
/
