create or replace package body k_filter is

	procedure before is
	begin
		r.setc('l$upload', '/upload/');
		r.setc('l$jscdn', 'https://cdnjs.cloudflare.com/ajax/libs/');
		r.setc('l$bootstrap.js', l('[jscdn]twitter-bootstrap/3.3.5/js/bootstrap.min.js'));
		r.setc('l$bootstrap.css', l('[jscdn]twitter-bootstrap/3.3.5/css/bootstrap.min.css'));
		r.setc('l$knockout.js', l('[jscdn]knockout/3.3.0/knockout-min.js'));
		r.setc('l$angular.js', l('[jscdn]angular.js/1.4.7/angular.min.js'));
		r.setc('l$angular-animate.js', l('[jscdn]angular.js/1.4.7/angular-animate.min.js'));
		r.setc('l$angular-resource.js', l('[jscdn]angular.js/1.4.7/angular-resource.min.js'));
	
		r.setc('l$bcdn', '//cdn.bootcss.com/');
		r.setc('l$animate.css', l('[bcdn]animate.css/3.4.0/animate.min.css'));
		r.setc('l$chart.js', l('[bcdn]Chart.js/1.0.1/Chart.min.js'));
		--r.setc('l$superagent.js', l('[bcdn]superagent/1.2.0/superagent.min.js'));
		r.setc('l$zepto.js', l('[bcdn]zepto/1.1.6/zepto.min.js'));
		r.setc('l$jquery.js', l('[bcdn]jquery/2.1.4/jquery.min.js'));
		r.setc('l$underscore.js', l('[bcdn]underscore.js/1.8.3/underscore-min.js'));
	
		-- b.set_line_break(null);
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
