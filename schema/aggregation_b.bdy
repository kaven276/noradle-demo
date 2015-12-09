create or replace package body aggregation_b is

	procedure common_css is
	begin
		b.l('<style>
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
		j.u('<link rel=stylesheet/>', '[bootstrap.css]');
		j.u('<link rel=stylesheet/>', '[animate.css]');
		common_css;
		j.t('<div.container.animated.zoomInDown>');
	end;

	function badge(cnt pls_integer) return varchar2 is
	begin
		return '&nbsp;' || j.t('<span.badge>', cnt);
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
		j.t('<table#report.table.table-bordered.table-hover rules=all>');
		j.t(' <caption.center>', 'staff hierachy with level');
		tmp.s := 'name,staff_num,grade,manager,leaf,path';
		j.t(' <thead.border.darkbg>', j.t('<tr>', m.w('<th>@</th>', tmp.s)));
		j.t(' <tbody.border>');
		for i in c loop
			j.p(1, i.is_leaf != 1);
			j.p(2, i.is_leaf = 1);
			j.t('<tr>');
			j.t(' <th>', rpad(' ', (i.lvl - 1) * 6 * 4 + 1, '&nbsp;') || i.first_name || ' ' || i.last_name);
			j.t(' <td>', i.employee_id);
			j.t(' <td>', i.lvl);
			j.t(' <td>', j.t('<span.flag.glyphicon.glyphicon-ok?>', ''));
			j.t(' <td>', j.t('<span.flag.glyphicon.glyphicon-ok?>2', ''));
			j.t(' <td>', i.path);
			j.t('</tr>');
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
		j.t('<table#report.table.table-bordered.table-hover rules=all>');
		j.t(' <caption.center>', 'group by with one-level rollup example');
		tmp.s := 'dept,emp,name,salary';
		j.t(' <thead.border.darkbg>', j.t('<tr>', m.w('<th>@</th>', tmp.s)));
		j.t(' <tbody.border>');
		for i in c loop
			case i.gid
				when 1 then
					j.p(1, i.cnt + 1);
					j.t('<tr>');
					j.t(' <th rowspan=?>', i.department_name);
					m.w(' <td>', st(badge(i.cnt), trunc(i.avg) || ' * ' || i.cnt, i.sal), '</td>');
					j.t('</tr>');
				when 0 then
					j.t('<tr>', m.w('<td>', st(i.employee_id, i.fname, i.sal), '</td>'));
				when 3 then
					j.t('</tbody>');
					j.t('<tfoot.border.darkbg>');
					j.t(' <tr>');
					j.t('  <th>', 'ALL DEPT');
					m.w('  <td>', st(badge(i.cnt), trunc(i.avg) || ' * ' || i.cnt, i.sal), '</td>');
					j.t(' </tr>');
					j.t('</tfoot>');
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
		j.t('<table#report.table.table-bordered.table-hover rules=all>');
		j.t(' <caption.center>', 'group by with multi-level rollup example');
		tmp.s := 'region,country,city,dept,emp';
		j.t(' <thead.border.darkbg>', j.t('<tr>', m.w('<th>@</th>', tmp.s)));
		j.t(' <tbody.border>');
		for i in c loop
			-- when order cann't change
			if not v_in_tr and i.r = 0 then
				j.t('<tr>');
				v_in_tr := true;
			end if;
			j.p(1, i.cnt);
			if i.r = 1 then
				-- last row
				j.t('</tbody>');
				j.t('<tfoot.border.darkbg>', j.t('<tr>', j.t('<th.center colspan=5>', 'total' || badge(i.cnt))));
			elsif i.c = 1 then
				j.t('<th.middle rowspan=?>', i.region_name || badge(i.cnt));
			elsif i.l = 1 then
				j.t('<th.middle rowspan=?>', i.country_name || badge(i.cnt));
			elsif i.d = 1 then
				j.t('<th.middle rowspan=?>', i.city || badge(i.cnt));
			elsif i.e = 1 then
				j.t('<th.middle rowspan=?>', i.department_name || badge(i.cnt));
			else
				j.t('<td>', i.fname);
				j.t('</tr>');
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
		j.t('<table#report.table.table-bordered.table-hover rules=all>');
		j.t(' <caption.indent>', 'cross table for h:job,v:dept, group by cube demo');
		j.t(' <thead.border.darkbg>');
		j.t('  <tr>');
		j.t('   <th colspan=3,rowspan=2>', 'departments\jobs');
		for i in (select j.job_id, j.job_title from jobs j order by j.job_id) loop
			j.p(1, i.job_title);
			j.t(' <th title=?>', i.job_id);
		end loop;
		for i in (select d.* from departments d order by d.department_id asc) loop
			v_dept_names(i.department_id) := i.department_name;
		end loop;
		j.t('  </tr>');
		j.t('  <tr>');
		for i in c loop
			if i.department_id = 0 then
				j.t('<th>', i.sal);
			else
				if v_header then
					j.t('</tr>');
					j.t('</thead>');
					j.t('<tbody.border>');
				end if;
				if i.job_id = '0' then
					if v_header then
						v_header := false;
					else
						j.t('</tr>');
					end if;
					j.p(1, v_dept_names(i.department_id));
					j.t('<tr>');
					j.t(' <th title=?>', i.department_id);
					j.t(' <th>', v_dept_names(i.department_id));
					j.t(' <th>', i.sal);
				else
					j.t('<td>', i.sal);
				end if;
			end if;
		end loop;
		j.t('</tr>');
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
		j.t('<table#report.table.table-bordered.table-hover rules=all>');
		j.t(' <caption.indent>', 'cross table for h:dept,v:job, group by cube demo');
		j.t(' <thead.border.darkbg>');
		j.t('  <tr>');
		j.t('   <th colspan=3,rowspan=2>', 'jobs/departments');
		for i in (select d.* from departments d order by d.department_id asc) loop
			j.p(1, i.department_name);
			j.t(' <th title=?>', i.department_id);
		end loop;
		for i in (select j.* from jobs j order by j.job_id asc) loop
			v_job_names(i.job_id) := i.job_title;
		end loop;
		j.t('  </tr>');
		j.t('  <tr>');
		for i in c loop
			if i.job_id = '0' then
				j.t('<th>', i.sal);
			else
				if v_header then
					j.t('</tr>');
					j.t('</thead>');
					j.t('<tbody.border>');
				end if;
				if i.department_id = 0 then
					if v_header then
						v_header := false;
					else
						j.t('</tr>');
					end if;
					j.p(1, v_job_names(i.job_id));
					j.t('<tr>');
					j.t(' <th title=?>', i.job_id);
					j.t(' <th>', v_job_names(i.job_id));
					j.t(' <th>', i.sal);
				else
					j.t(' <td>', i.sal);
				end if;
			end if;
		end loop;
		j.t('</tr>');
	end;

end aggregation_b;
/
