create or replace package body aggregation_b is

	procedure common_css is
	begin
		x.t('<style>
		.center {text-align: center;}
		.border {border: 3px solid gray;}  
		.darkbg {background-color: silver;}	
		.table th.middle {vertical-align: middle;}
		.flag {color:green}
		.indent {text-indent:2em;}
	  </style>');
	end;

	procedure common_preface is
	begin
		src_b.header;
		x.l('<link>', '[bootstrap.css]');
		x.l(' <link>', '[animate.css]');
		common_css;
		x.o('<div.container.animated.zoomInDown>');
	end;

	function badge(cnt pls_integer) return varchar2 is
	begin
		return x.r('&nbsp;<span class="badge">@</span>', cnt);
	end;

	procedure emp_managers is
		cursor c is
			select e.*,
						 level as lvl,
						 connect_by_isleaf as is_leaf,
						 sys_connect_by_path(last_name, '/') as path,
						 connect_by_root last_name as manager
				from employees e
			 start with e.manager_id = (select a.employee_id from employees a where a.manager_id is null)
			connect by prior e.employee_id = e.manager_id
			 order siblings by e.last_name asc;
	begin
		--p.h('u:hierachical.css,u:pw/pw.js,u:pw/treeble.js,u:.js');
		common_preface;
		x.o('<table#report.table.table-bordered.table-hover rules=all>');
		x.p(' <caption.center>', 'staff hierachy with level');
		tmp.s := 'name,staff_num,grade,manager,leaf,path';
		x.p(' <thead.border.darkbg>', x.p('<tr>', m.w('<th>@</th>', tmp.s)));
		x.o(' <tbody.border>');
		for i in c loop
			x.o('<tr>');
			x.p(' <th>', rpad(' ', (i.lvl - 1) * 6 * 4 + 1, '&nbsp;') || i.first_name || ' ' || i.last_name);
			x.p(' <td>', i.employee_id);
			x.p(' <td>', i.lvl);
			x.p(' <td>', x.p('<span.:1>', '', st(t.tf(i.is_leaf != 1, 'flag glyphicon glyphicon-ok'))));
			x.p(' <td>', x.p('<span.:1>', '', st(t.tf(i.is_leaf = 1, 'flag glyphicon glyphicon-ok'))));
			x.p(' <td>', i.path);
			x.c('</tr>');
		end loop;
	end;

	procedure emp_salaries is
		cursor c is
			select grouping_id(d.department_name, e.employee_id) gid,
						 d.department_name,
						 e.employee_id,
						 max(e.first_name || ' ' || e.last_name) as fname,
						 sum(e.salary) sal,
						 count(*) cnt,
						 avg(e.salary) avg
				from employees e, departments d
			 where e.department_id = d.department_id
			 group by rollup(d.department_name, e.employee_id)
			 order by 2 nulls last, 1 desc, 5 desc;
	begin
		common_preface;
		x.o('<table#report.table.table-bordered.table-hover rules=all>');
		x.p(' <caption.center>', 'group by with one-level rollup example');
		tmp.s := 'dept,emp,name,salary';
		x.p(' <thead.border.darkbg>', x.p('<tr>', m.w('<th>@</th>', tmp.s)));
		x.o(' <tbody.border>');
		for i in c loop
			case i.gid
				when 1 then
					x.o('<tr>');
					x.p(' <th rowspan=:1>', i.department_name, st(i.cnt + 1));
					m.w(' <td>', st(badge(i.cnt), trunc(i.avg) || ' * ' || i.cnt, i.sal), '</td>');
					x.c('</tr>');
				when 0 then
					x.p('<tr>', m.w('<td>', st(i.employee_id, i.fname, i.sal), '</td>'));
				when 3 then
					x.c('</tbody>');
					x.o('<tfoot.border.darkbg>');
					x.o(' <tr>');
					x.p('  <th>', 'ALL DEPT');
					m.w('  <td>', st(badge(i.cnt), trunc(i.avg) || ' * ' || i.cnt, i.sal), '</td>');
					x.c(' </tr>');
					x.c('</tfoot>');
			end case;
		end loop;
	end;

	procedure emp_groups_list is
		v_in_tr boolean := false;
		cursor c is
			select r.region_name,
						 c.country_name,
						 l.city,
						 d.department_name,
						 e.employee_id,
						 max(e.first_name || ' ' || e.last_name) as fname,
						 count(*) cnt,
						 grouping(r.region_name) r,
						 grouping(c.country_name) c,
						 grouping(l.city) l,
						 grouping(d.department_name) d,
						 grouping(e.employee_id) e
				from employees e
				join departments d
			 using (department_id)
				join locations l
			 using (location_id)
				join countries c
			 using (country_id)
				join regions r
			 using (region_id)
			 where department_id is not null
			 group by rollup(r.region_name, c.country_name, l.city, d.department_name, e.employee_id)
			 order by 1, 2 nulls first, 3 nulls first, 4 nulls first, 5 nulls first, 6;
	begin
		common_preface;
		x.o('<table#report.table.table-bordered.table-hover rules=all>');
		x.p(' <caption.center>', 'group by with multi-level rollup example');
		tmp.s := 'region,country,city,dept,emp';
		x.p(' <thead.border.darkbg>', x.p('<tr>', m.w('<th>@</th>', tmp.s)));
		x.o(' <tbody.border>');
		for i in c loop
			-- when order cann't change
			if not v_in_tr and i.r = 0 then
				x.o('<tr>');
				v_in_tr := true;
			end if;
			if i.r = 1 then
				-- last row
				x.c('</tbody>');
				x.p('<tfoot.border.darkbg>', x.p('<tr>', x.p('<th.center colspan=5>', 'total' || badge(i.cnt))));
			elsif i.c = 1 then
				x.p('<th.middle rowspan=:1>', i.region_name || badge(i.cnt), st(i.cnt));
			elsif i.l = 1 then
				x.p('<th.middle rowspan=:1>', i.country_name || badge(i.cnt), st(i.cnt));
			elsif i.d = 1 then
				x.p('<th.middle rowspan=:1>', i.city || badge(i.cnt), st(i.cnt));
			elsif i.e = 1 then
				x.p('<th.middle rowspan=:1>', i.department_name || badge(i.cnt), st(i.cnt));
			else
				x.p('<td>', i.fname);
				x.c('</tr>');
				v_in_tr := false;
			end if;
		end loop;
	end;

	procedure job_dept_sals is
		v_header boolean := true;
		type idx is table of varchar2(30) index by binary_integer;
		v_dept_names idx;
		cursor c is
			select department_id, job_id, a.sal
				from (select nvl(e.department_id, 0) department_id, nvl(e.job_id, '0') job_id, trunc(avg(e.salary)) sal
								from employees e
							 where e.department_id is not null
							 group by cube(e.job_id, e.department_id)) a
			 right outer join (select d.department_id, j.job_id, null sal
													 from departments d, jobs j
												 union all
												 select d.department_id, '0' job_id, null sal
													 from departments d
												 union all
												 select 0 department_id, j.job_id, null sal from jobs j) b
			 using (department_id, job_id)
			 order by department_id asc nulls first, job_id asc nulls last;
	begin
		common_preface;
		x.o('<table#report.table.table-bordered.table-hover rules=all>');
		x.p(' <caption.indent>', 'cross table for h:job,v:dept, group by cube demo');
		x.o(' <thead.border.darkbg>');
		x.o('  <tr>');
		x.p('   <th colspan=3,rowspan=2>', 'departments\jobs');
		for i in (select j.job_id, j.job_title from jobs j order by j.job_id) loop
			x.p(' <th title=:1>', i.job_id, st(i.job_title));
		end loop;
		for i in (select d.* from departments d order by d.department_id asc) loop
			v_dept_names(i.department_id) := i.department_name;
		end loop;
		x.c('  </tr>');
		x.o('  <tr>');
		for i in c loop
			if i.department_id = 0 then
				x.p('<th>', i.sal);
			else
				if v_header then
					x.c('</tr>');
					x.c('</thead>');
					x.o('<tbody.border>');
				end if;
				if i.job_id = '0' then
					if v_header then
						v_header := false;
					else
						x.c('</tr>');
					end if;
					x.o('<tr>');
					x.p(' <th title=:1>', i.department_id, st(v_dept_names(i.department_id)));
					x.p(' <th>', v_dept_names(i.department_id));
					x.p(' <th>', i.sal);
				else
					x.p('<td>', i.sal);
				end if;
			end if;
		end loop;
		x.c('</tr>');
	end;

	procedure dept_job_sals is
		v_header boolean := true;
		type idx is table of varchar2(100) index by varchar2(30);
		v_job_names idx;
		cursor c is
			select department_id, job_id, a.sal
				from (select nvl(e.department_id, 0) department_id, nvl(e.job_id, '0') job_id, trunc(avg(e.salary)) sal
								from employees e
							 where e.department_id is not null
							 group by cube(e.job_id, e.department_id)) a
			 right outer join (select d.department_id, j.job_id, null sal
													 from departments d, jobs j
												 union all
												 select d.department_id, '0' job_id, null sal
													 from departments d
												 union all
												 select 0 department_id, j.job_id, null sal from jobs j) b
			 using (department_id, job_id)
			 order by job_id asc nulls last, department_id asc nulls last;
	begin
		common_preface;
		x.o('<table#report.table.table-bordered.table-hover rules=all>');
		x.p(' <caption.indent>', 'cross table for h:dept,v:job, group by cube demo');
		x.o(' <thead.border.darkbg>');
		x.o('  <tr>');
		x.p('   <th colspan=3,rowspan=2>', 'jobs/departments');
		for i in (select d.* from departments d order by d.department_id asc) loop
			x.p(' <th title=:1>', i.department_id, st(i.department_name));
		end loop;
		for i in (select j.* from jobs j order by j.job_id asc) loop
			v_job_names(i.job_id) := i.job_title;
		end loop;
		x.c('  </tr>');
		x.o('  <tr>');
		for i in c loop
			if i.job_id = '0' then
				x.p('<th>', i.sal);
			else
				if v_header then
					x.c('</tr>');
					x.c('</thead>');
					x.o('<tbody.border>');
				end if;
				if i.department_id = 0 then
					if v_header then
						v_header := false;
					else
						x.c('</tr>');
					end if;
					x.o('<tr>');
					x.p(' <th title=:1>', i.job_id, st(v_job_names(i.job_id)));
					x.p(' <th>', v_job_names(i.job_id));
					x.p(' <th>', i.sal);
				else
					x.p(' <td>', i.sal);
				end if;
			end if;
		end loop;
		x.c('</tr>');
	end;

end aggregation_b;
/
