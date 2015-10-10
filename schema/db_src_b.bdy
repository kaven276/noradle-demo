create or replace package body db_src_b is

	procedure basic is
		cur sys_refcursor;
	begin
		src_b.header;
		if not r.is_null('template') then
			h.convert_json_template(r.getc('template'), r.getc('engine'));
		end if;
	
		--h.etag_md5_on;
		if r.is_lack('inspect') then
			rs.use_remarks;
			h.line('# a stardard psp.web result sets example page');
			h.line('# It can be used in browser or NodeJS');
			h.line('# You can use some standard parser or write your own ' ||
						 'parsers to convert the raw resultsets to javascript data object');
			h.line('# see PL/SQL source at ' || r.dir_full || '/src_b.proc/' || r.prog);
		end if;
	
		open cur for
			select a.object_name, a.subobject_name, a.object_type, a.created
				from user_objects a
			 where rownum <= r.getn('limit', 3);
		rs.print('objects', cur);
	end;

	procedure pack_proc is
		cur sys_refcursor;
	begin
    src_b.header;
		open cur for
			select a.object_name pack, a.created, a.status
				from user_objects a
			 where a.object_type = 'PACKAGE'
			 order by 1 asc;
		rs.print('packages^-', cur);
	
		open cur for
			select a.object_name pack, a.procedure_name proc, a.subprogram_id
				from user_procedures a
			 where a.object_type = 'PACKAGE'
				 and a.procedure_name is not null
			 order by a.object_name asc, a.subprogram_id asc;
		rs.print('procedures/-pack|packages/pack', cur);
	
		open cur for
			select a.object_name pack, a.procedure_name "-"
				from user_procedures a
			 where a.object_type = 'PACKAGE'
				 and a.procedure_name is not null
			 order by a.object_name asc, a.subprogram_id asc;
		rs.print('procs|packages', cur);
	end;

	procedure scalar_array is
		cur sys_refcursor;
	begin
    src_b.header;
		open cur for
			select a.object_name "-" from user_objects a where a.object_type = 'PACKAGE' order by 1 asc;
		rs.print('packages', cur);
	end;

	procedure pack_kv is
		cur sys_refcursor;
	begin
    src_b.header;
		open cur for
			select a.object_name pack, a.created, a.status
				from user_objects a
			 where a.object_type = 'PACKAGE'
			 order by 1 asc;
		rs.print('packages^-', cur);
	end;

	procedure pack_kv_child is
		cur sys_refcursor;
	begin
    src_b.header;
		open cur for
			select a.object_name pack, a.created, a.status
				from user_objects a
			 where a.object_type = 'PACKAGE'
			 order by 1 asc;
		rs.print('packages^-', cur);
	
		open cur for
			select a.object_name pack, a.procedure_name proc, a.subprogram_id
				from user_procedures a
			 where a.object_type = 'PACKAGE'
				 and a.procedure_name is not null
			 order by a.object_name asc, a.subprogram_id asc;
		rs.print('procedures^-proc/-pack|packages/pack', cur);
	end;

	procedure tab_pack_proc is
		cur sys_refcursor;
	begin
		null;
	end;

	procedure scalars_sql is
		cur sys_refcursor;
		v1  varchar2(50) := 'psp.web';
		v2  number := 123456;
		v3  date := date '1976-10-26';
	begin
    src_b.header;
		open cur for
			select v1 as name, v2 as val, v3 as ctime, r.getc('param1') p1, r.getc('param2') p2, r.getc('__parse') pnull
				from dual;
		rs.print('namevals', cur);
	end;

	procedure scalars_direct is
	begin
    src_b.header;
		h.convert_json;
		rs.nv('name', 'kaven276');
		rs.nv('age', 39);
		rs.nv('birth', sysdate - 39);
		rs.nv('married', true);
	end;

end db_src_b;
/
