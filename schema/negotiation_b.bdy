create or replace package body negotiation_b is

	procedure languages_by_browser is
	begin
		if instr(r.header('accept-language'), 'el') > 0 then
			pc.h;
			src_b.link_proc;
			x.p('<p>', 'OK, This page have Greece charracters your browser accept.');
			x.p('<p>',
					utl_i18n.raw_to_nchar('CEB1CEB2CEB3CEB4CEB5CEB6CEB7CEB8CEB9CEBACEBBCEBCCEBDCEBECEBECEBFCEBFCF81CF83CF84CF85CF86CF87CF88CF89',
																'UTF8'));
		elsif instr(r.header('accept-language'), 'zh') > 0 then
			pc.h;
			src_b.link_proc;
			x.p('<p>', 'OK, This page have chinese charracters your browser accept.');
			x.p('<p>',
					utl_i18n.raw_to_nchar('E5A4A7E5AEB6E5A5BDEFBC8CE8BF99E698AFE4B8ADE69687E78988E7BD91E9A1B5E38082', 'AL32UTF8'));
		else
			h.sts_406_not_acceptable;
			pc.h;
			src_b.link_proc;
			x.p('<p>',
					'This page is for Greece reader only, You browser accepts "' || r.header('Accept-Language') || '" only.');
		end if;
		x.p('<p>', 'If the request''s accept headers can not be supported, return 406 not acceptable is ok.');
		x.p('<p>', 'set your browser language to have zh(chinese), el(greece) to see versions of the page.');
	end;

	procedure accepts_best_match is
	begin
		x.p('<style>', 'dl{line-height:1.5em;}');
	
		x.p('<h3>', 'accept');
		x.o('<dl>');
		x.p('<dt>', 'r.header(''accept'')');
		x.p('<dd>', r.header('accept'));
		x.p('<dt>', 'r.dump(''h$accepts'')');
		x.p('<dd>', r.dump('h$accepts'));
		x.p('<dt>', 'r.negotiation(''h$accepts'', ''text/xml'')');
		x.p('<dd>', r.negotiation('h$accepts', 'text/xml'));
		x.c('</dl>');
	
		x.p('<h3>', 'accept-charset');
		x.o('<dl>');
		x.p('<dt>', 'r.header(''accept-charset'')');
		x.p('<dd>', nvl(r.header('accept-charset'), 'none'));
		x.p('<dt>', 'r.dump(''h$accept-charsets'')');
		x.p('<dd>', r.dump('h$accept-charsets'));
		x.p('<dt>', 'r.negotiation(''h$accept-charsets'', ''zhs'')');
		x.p('<dd>', r.negotiation('h$accept-charsets', 'zhs'));
		x.c('</dl>');
	
		x.p('<h3>', 'accept-language');
		x.o('<dl>');
		x.p('<dt>', 'r.header(''accept-language'')');
		x.p('<dd>', nvl(r.header('accept-language'), 'none'));
		x.p('<dt>', 'r.dump(''h$accept-languages'')');
		x.p('<dd>', r.dump('h$accept-languages'));
		x.p('<dt>', 'r.negotiation(''h$accept-languages'', ''zh'')');
		x.p('<dd>', r.negotiation('h$accept-languages', 'zh'));
		x.c('</dl>');
	
		x.p('<h3>', 'accept-encoding');
		x.o('<dl>');
		x.p('<dt>', 'r.header(''accept-encoding'')');
		x.p('<dd>', nvl(r.header('accept-encoding'), 'none'));
		x.p('<dt>', 'r.dump(''h$accept-encodings'')');
		x.p('<dd>', r.dump('h$accept-encodings'));
		x.p('<dt>', 'r.negotiation(''h$accept-encodings'', ''deflate'')');
		x.p('<dd>', r.negotiation('h$accept-encodings', 'deflate'));
		x.c('</dl>');
	end;

end negotiation_b;
/
