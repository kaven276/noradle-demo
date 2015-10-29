create or replace package body k_filter is

	procedure before is
	begin
	
		-- url [jquery] is alwarys available
		r.setc('l$jquery', l('^bower_lib/jquery/dist/jquery.min.js'));
		r.setc('l$myself', l('^'));
	
		-- h.set_line_break(null);
		pv.id  := 'liyong';
		pv.now := sysdate;
	
		if auth_s.user_name is not null then
			auth_b.check_update;
		end if;
	
		return;
	
		if true then
			pc.h;
			x.p('<p>', 'execute in k_filter.before only, cancel execute the main prog');
			g.cancel;
		end if;
	end;

	procedure after is
		pragma autonomous_transaction;
	begin
		if r.prog = 'filter_b.see_filter' then
			x.p('<h3>', 'k_filter.after write here. Exiting?');
			x.p('<h3>', 'k_filter.after can be used to do logging using autonomous_transaction');
		end if;
		if not r.is_lack('inspect') then
			src_b.footer;
		end if;
	end;

end k_filter;
/
