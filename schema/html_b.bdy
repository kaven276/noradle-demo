create or replace package body html_b is

	procedure bind_data is
		cursor c_packages is
			select *
				from user_objects a
			 where a.object_type = 'PACKAGE'
				 and rownum <= 5
			 order by a.object_name asc;
	begin
		pc.h;
		src_b.header;
		x.o('<table rules=all,cellspacing=0,cellpadding=5,style=border:1px solid silver;>');
		x.p(' <caption>', 'bind sql data to table example');
		x.p(' <thead>', x.p('<tr>', m.w('<th>@</th>', 'package name,created')));
		x.o(' <tbody>');
		for i in c_packages loop
			x.o('<tr>');
			x.p(' <td>', i.object_name);
			x.p(' <td>', t.d2s(i.created));
			x.c('</tr>');
		end loop;
		x.c(' </tbody>');
		x.c('</table>');
	end;

	procedure component_css is
		v_link boolean;
	
		procedure component1 is
		begin
			x.o('<div#id1>');
			y.lcss_ctx('#id1');
			y.lcss('p{line-height:1.5em;margin:0px 2em;color:gray;}');
			x.p('<p>',
					'This is div component with some p in it, This div component can control it''s css within itself,' ||
					'no matter which page include the div, the css assosiated with the div is there.');
			x.c('</div>');
		end;
	
		procedure component2 is
		begin
			x.o('<form#id2>');
			y.lcss_ctx('#id2');
			y.lcss('{border:3px solid blue;border-radius:12px;}');
			y.lcss('input {border:1px solid silver;}');
			x.p('  <label>', 'label' || x.s('<input type=text,name=n,value=text>'));
			x.c('</form>');
		end;
	
	begin
		h.content_encoding_try_zip;
		x.t('<!DOCTYPE html>');
		x.o('<html>');
		x.o('<head>');
		x.p(' <title>', 'component css');
		case r.getc('link', '')
			when 'Y' then
				y.embed(r.getc('tag', '<link>'));
			when 'N' then
				y.embed(r.getc('tag', '<style>'));
			else
				null;
		end case;
		x.c('</head>');
		x.o('<body>');
	
		src_b.link_proc;
		component1;
		component2;
	end;

	procedure regen_page is
	begin
		pc.h;
		x.p('<p>', 'This is the first generated page.');
	
		b.print_init(true); -- this line will reset page output
		pc.h;
		src_b.link_proc;
		x.p('<p>', 'This is the second generated page that replace the first generated page.');
	end;

	procedure component is
		v_dhc boolean := b.written = 0;
	begin
		if v_dhc then
			pc.h;
			src_b.link_proc;
			x.p('<p>', 'I''m in direct http access mode.');
		else
			x.t('<br/>');
			src_b.link_proc('html_b.component');
			x.p('<p>', 'I''m included in ' || r.prog || ' as a component.');
		end if;
		x.p('<p>', 'My proc name is html_b.component.');
		x.p('<p>', 'Use direct http access to component is good for reuse and testing.');
	end;

	procedure complex is
	begin
		pc.h;
		src_b.link_proc;
		x.p('<p>', 'I''m a page composed of components');
		component;
		x.t('<br/>');
	end;

end html_b;
/
