create or replace package body jquery_mobile_b is

	procedure list_regions is
	begin
		o.t('<div -role=page>');
		o.t(' <div -role=header>');
		o.t('  <h1>', 'regions');
		o.t(' </div>');
		o.t(' <ul.ui-content -role=listview -inset=true -filter=true -filter-placeholder=search>');
		for i in (select a.*, (select count(*) from countries b where b.region_id = a.region_id) country_cnt from regions a) loop
			o.t('<li>',
					o.u(' <a>',
							'@b.list_countries?region_id=' || i.region_id,
							i.region_name || o.t('<span.ui-li-count>', i.country_cnt)));
		end loop;
		o.t(' </ul>');
		o.t('</div>');
	end;

	procedure list_countries is
		v countries%rowtype;
	begin
		v.region_id := r.getc('region_id');
		o.t('<div -role=page>');
		o.t(' <div -role=header>');
		o.t('  <h1>', 'countries');
		o.t(' </div>');
		o.t(' <ul.ui-content -role=listview -inset=true>');
		for i in (select a.*,
										 (select count(*)
												from departments b
												join locations c
											 using (location_id)
												join countries d
											 using (country_id)
											 where d.region_id = a.region_id) dept_cnt
								from countries a
							 where a.region_id = v.region_id) loop
			o.t('<li>',
					o.u('<a>',
							'@b.list_departments?country_id=' || i.country_id,
							i.country_name || o.t('<span.ui-li-count>', i.dept_cnt)));
		end loop;
		o.t(' </ul>');
		o.t('</div>');
	end;

	procedure list_departments is
	begin
		o.t('<div -role=page>');
		o.t(' <div -role=header>');
		o.t('  <h1>', 'departments');
		o.t(' </div>');
		o.t(' <ul.ui-content -role=listview -inset=true>');
		for i in (select a.department_id,
										 a.department_name,
										 (select count(*) from employees d where d.department_id = a.department_id) emp_cnt
								from departments a
								join locations b
							 using (location_id)
								join countries c
							 using (country_id)
							 where country_id = r.getc('country_id')) loop
			o.t('<li>',
					o.u('<a>',
							'@b.list_employees?department_id=' || i.department_id,
							i.department_name || o.t('<span.ui-li-count>', i.emp_cnt)));
		end loop;
		o.t(' </ul>');
		o.t('</div>');
	end;

	procedure list_employees is
	begin
		o.t('<div -role=page>');
		o.t(' <div -role=header>');
		o.t('  <h1>', 'employees');
		o.t(' </div>');
		o.t(' <ul.ui-content -role=listview -inset=true>');
		for i in (select a.* from employees a where a.department_id = r.getc('department_id')) loop
			o.t('<li>', o.u('<a>', '@b.show_employee?employee_id=' || i.employee_id, i.first_name || ' . ' || i.last_name));
		end loop;
		o.t(' </ul>');
		o.t('</div>');
	end;

	procedure d is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[jquery.mobile.css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[jquery.mobile.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://jquerymobile.com/', 'jquery-mobile official site'));
		list_regions;
	end;

end jquery_mobile_b;
/
