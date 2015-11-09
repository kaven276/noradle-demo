create or replace package body local_css_b is

	procedure d is
		procedure component1(name varchar2) is
		begin
			-- css rule only for this component1
			if r.is_lack('lcss$component1') then
				r.setn('lcss$component1', 1);
				x.t('<style>.c1{color:red;}</style>');
			end if;
			x.p('<p.c1>', name);
		end;
	
		procedure component2(name varchar2) is
		begin
			-- css rule only for this component2
			if r.is_lack('lcss$component2') then
				r.setn('lcss$component2', 1);
				x.t('<style>.c2{color:blue;}</style>');
			end if;
			x.p('<p.c2>', name);
		end;
	begin
		x.o('<body>');
		if r.getb('reorder') then
			x.o('<script#buffer type=text>');
		end if;
	
		src_b.header;
	
		x.p('<p>', 'note: css rule set just before usage of them, print only once, no repeat');
		x.p('<p>', x.a('<a>', 'link to plain version', r.prog));
		x.p('<p>', x.a('<a>', 'link to reorder source version', r.prog || '?reorder=y'));
	
		x.p('<h3>', 'include component1 with each package names');
		for i in (select a.object_name
								from user_objects a
							 where a.object_type = 'PACKAGE'
								 and rownum < 4) loop
			component1(i.object_name);
		end loop;
		x.p('<h3>', 'include component2 with each none-package object names');
		for i in (select a.object_name
								from user_objects a
							 where a.object_type != 'PACKAGE'
								 and rownum < 4) loop
			component2(i.object_name);
		end loop;
	
		if r.getb('reorder') then
			x.c('</script>');
			x.t('<script id="reorder">
		(function(){
			var domBuffer = document.getElementById("buffer")
			 , domReorder = document.getElementById("reorder")
			 , text = domBuffer.innerText
			 , re = /<style>[^<>]*<\/style>\n?/gm
			 , body = text.replace(re,"")
			 , style = text.match(re).join("\n").replace(/(<style>|<\/style>)/g,"")
			 ;
			document.head.insertAdjacentHTML("beforeEnd","<style>" + style + "</style>");
			if(false){
				document.body.removeChild(domBuffer);
				document.body.removeChild(domReorder);
				document.body.insertAdjacentHTML("beforeEnd",body);
			} else {
				document.body.innerHTML = body;
			}
			})();
		</script>');
		end if;
	
	end;
end local_css_b;
/
