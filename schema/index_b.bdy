create or replace package body index_b is

	procedure frame is
	begin
		x.t('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">');
		x.o('<html>');
		x.o('<head>');
		x.p(' <title>', 'PSP.WEB test/demo suite');
		x.c('</head>');
		x.o('<frameset cols=:1,frameborder=yes>', st('280,*'));
		x.j(' <frame name=dir,scrolling=true,style=border-right:1px solid gray;overflow-y:scroll;>', '@b.dir');
		x.j(' <frame name=page>', '@b.page');
		x.c('</frameset>');
		x.c('</html>');
	end;

	procedure dir is
	begin
		pc.h(target => 'page');
		x.t('<style>html{background:url(:1)}</style>', st(l('^img/subtle_freckles.png')));
		x.o('<dl>');
	
		x.p('<dt>', 'ora_good_b');
		x.p('<dd>', x.a('<a>', 'introduce', 'ora_good_b.entry'));
	
		x.p('<dt>', 'basic input output');
		x.p('<dd>', x.a('<a>', 'req_info', 'basic_io_b.req_info'));
		x.p('<dd>', x.a('<a>', 'output', 'basic_io_b.output'));
		x.p('<dd>', x.a('<a>', 'parameters', 'basic_io_b.parameters'));
		x.p('<dd>', x.a('<a>', 'keep_urlencoded', 'basic_io_b.keep_urlencoded'));
		x.p('<dd>', x.a('<a>', 'steps', 'basic_io_b.steps'));
		x.p('<dd>', x.a('<a>', 'list data', 'basic_io_b.appended'));
		x.p('<dd>', x.a('<a>', 'show no data', 'basic_io_b.appended?name=*'));
	
		x.p('<dt>', 'post/upload file');
		x.p('<dd>', x.a('<a>', 'upload_form', 'post_file_b.upload_form'));
		x.p('<dd>', x.a('<a>', 'ajax_post', 'post_file_b.ajax_post'));
		x.p('<dd>', x.a('<a>', 'post json', 'post_file_b.ajax_post_json'));
		x.p('<dd>', x.a('<a>', 'media capture', 'media_b.file_image'));
	
		x.p('<dt>', 'http response control headers');
		x.p('<dd>', x.a('<a>', 'gzip', 'http_b.gzip'));
		x.p('<dd>', x.a('<a>', 'chunked_transfer', 'http_b.chunked_transfer'));
		x.p('<dd>', x.a('<a>', 'long_job', 'http_b.long_job'));
		x.p('<dd>', x.a('<a>', 'content_type', 'http_b.content_type'));
		x.p('<dd>', x.a('<a>', 'refresh to self', 'http_b.refresh'));
		x.p('<dd>', x.a('<a>', 'refresh to other', 'http_b.refresh?to=index_b.page'));
		x.p('<dd>', x.a('<a>', 'content_md5', 'http_b.content_md5'));
	
		x.p('<dt>', 'mimic file download');
		x.p('<dd>', x.a('<a>', 'd', 'file_dl_b.d'));
		x.p('<dd>', x.a('<a>', 'text', 'file_dl_b.text'));
		x.p('<dd>', x.a('<a>', 'excel', 'file_dl_b.excel'));
		x.p('<dd>', x.a('<a>', 'word', 'file_dl_b.excel'));
	
		x.p('<dt>', 'about cookie');
		x.p('<dd>', x.a('<a>', 'set/view cookie', 'cookie_h.form_view'));
	
		x.p('<dt>', 'rs(resultset) data service');
		x.p('<dd>', x.a('<a>', 'example', 'db_src_b.basic?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'example(jade)', 'db_src_b.basic?template=test.jade'));
		x.p('<dd>', x.a('<a>', 'example(mustache)', 'db_src_b.basic?template=test.mst'));
		x.p('<dd>', x.a('<a>', 'example(handlebars)', 'db_src_b.basic?template=test.hbs'));
		x.p('<dd>', x.a('<a>', 'example(swig)', 'db_src_b.basic?template=test.swig'));
		x.p('<dd>', x.a('<a>', 'example(ejs)', 'db_src_b.basic?template=test.ejs'));
		x.p('<dd>', x.a('<a>', 'scalar data types(SQL)', 'db_src_b.scalars_sql?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'scalar data types(API)', 'db_src_b.scalars_direct?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'scalar array', 'db_src_b.scalar_array?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'parent-children data', 'db_src_b.pack_proc?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'key-value', 'db_src_b.pack_kv?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'key-value(child)', 'db_src_b.pack_kv_child?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'direct_json', 'db_src_b.direct_json?inspect&markdown'));
		x.p('<dd>', x.a('<a>', 'set_mime_no_convert', 'db_src_b.set_mime_no_convert?inspect&markdown'));
	
		x.p('<dt>', 'html output');
		x.p('<dd>', x.a('<a>', 'bind data in html', 'html_b.bind_data'));
		x.p('<dd>', x.a('<a>', 'regen_page', 'html_b.regen_page'));
		x.p('<dd>', x.a('<a>', 'component', 'html_b.component'));
		x.p('<dd>', x.a('<a>', 'complex', 'html_b.complex'));
	
		x.p('<dt>', 'x(tag) print');
		x.p('<dd>', x.a('<a>', 'tags', 'x_tag_b.tags'));
		x.p('<dd>', x.a('<a>', 'tag_attr', 'x_tag_b.tag_attr'));
		x.p('<dd>', x.a('<a>', 'url_link', 'x_tag_b.url_link'));
		x.p('<dd>', x.a('<a>', 'form_item_value', 'x_tag_b.form_item_value'));
		x.p('<dd>', x.a('<a>', 'text', 'x_tag_b.text'));
		x.p('<dd>', x.a('<a>', 'bool_attr', 'x_tag_b.bool_attr'));
	
		x.p('<dt>', 'm(multi) print');
		x.p('<dd>', x.a('<a>', 'wrap_each_array_value', 'm_multi_b.wrap_each_array_value'));
		x.p('<dd>', x.a('<a>', 'wrap_array_in_loop', 'm_multi_b.wrap_array_in_loop'));
		x.p('<dd>', x.a('<a>', 'parse_render_st', 'm_multi_b.parse_render_st'));
		x.p('<dd>', x.a('<a>', 'parse_render_st_boolean', 'm_multi_b.parse_render_st_boolean'));
		x.p('<dd>', x.a('<a>', 'parse_render_cursor', 'm_multi_b.parse_render_cursor'));
		x.p('<dd>', x.a('<a>', 'nv_form_select_options', 'm_multi_b.nv_form_select_options'));
		x.p('<dd>', x.a('<a>', 'nv_form_radios', 'm_multi_b.nv_form_radios'));
		x.p('<dd>', x.a('<a>', 'nv_form_checkboxes', 'm_multi_b.nv_form_checkboxes'));
	
		x.p('<dt>', 'tr(tree) printing');
		x.p('<dd>', x.a('<a>', 'parse_render_in_loop', 'tree_b.parse_render_in_loop'));
		x.p('<dd>', x.a('<a>', 'parse_open_render_cur_close', 'tree_b.parse_open_render_cur_close'));
		x.p('<dd>', x.a('<a>', 'parse_render_cur_united', 'tree_b.parse_render_cur_united'));
		x.p('<dd>', x.a('<a>', 'hier_node_level_in_loop', 'tree_b.hier_node_level_in_loop'));
		x.p('<dd>', x.a('<a>', 'hier_node_all_types', 'tree_b.hier_node_all_types'));
	
		x.p('<dt>', 'tb(table) formating/printing');
		x.p('<dd>', x.a('<a>', 'for loop print', 'list_b.user_objects'));
		x.p('<dd>', x.a('<a>', 'multi.c print', 'list_b.user_objects_cur'));
		x.p('<dd>', x.a('<a>', 'sys_refcursor print', 'list_b.user_procedures'));
	
		x.p('<dt>', 'l(link) to url');
		x.p('<dd>', x.a('<a>', 'link_transparent', 'easy_url_b.link_transparent'));
		x.p('<dd>', x.a('<a>', 'link_equal_to', 'easy_url_b.link_equal_to'));
		x.p('<dd>', x.a('<a>', 'link_proc_in_same_pack', 'easy_url_b.link_proc_in_same_pack'));
		x.p('<dd>', x.a('<a>', 'link_proc_in_any_pack', 'easy_url_b.link_proc_in_any_pack'));
		x.p('<dd>', x.a('<a>', 'link_standalone_proc', 'easy_url_b.link_standalone_proc'));
		x.p('<dd>', x.a('<a>', 'link_static_for_site', 'easy_url_b.link_static_for_site'));
		x.p('<dd>', x.a('<a>', 'link_static_for_pack', 'easy_url_b.link_static_for_pack'));
		x.p('<dd>', x.a('<a>', 'link_static_for_me', 'easy_url_b.link_static_for_me'));
		x.p('<dd>', x.a('<a>', 'link_other_parallel_app_static', 'easy_url_b.link_other_parallel_app_static'));
		x.p('<dd>', x.a('<a>', 'link_configured_url', 'easy_url_b.link_configured_url'));
		x.p('<dd>', x.a('<a>', 'use_base_url_for_static', 'easy_url_b.use_base_url_for_static'));
		x.p('<dd>', x.a('<a>', 'all patterns', 'easy_url_b.d'));
		x.p('<dd>', x.a('<a>', 'links in standalone procedure', './url_test1_b'));
		x.p('<dd>', x.a('<a>', 'param use t.ps and tmp.stv', 'easy_url_b.param_use_stv'));
		x.p('<dd>', x.a('<a>', 'param interpolate', 'easy_url_b.param_interpolate'));
		x.p('<dd>', x.a('<a>', 'param use vqstr', 'easy_url_b.param_use_vqstr'));
		x.p('<dd>', x.a('<a>', 'param tail', 'easy_url_b.param_tail'));
		x.p('<dd>', x.a('<a>', 'param interpolate&tail', 'easy_url_b.param_interpolate_tail'));
		x.p('<dd>', x.a('<a>', 'url relay', 'easy_url_b.url_relay'));
	
		x.p('<dt>', 'css related');
		x.p('<dd>', x.a('<a>', 'component_css?link=Y', 'html_b.component_css?link=Y'));
		x.p('<dd>', x.a('<a>', 'component_css?link=N', 'html_b.component_css?link=N'));
		x.p('<dd>', x.a('<a>', 'css in HTML API(embeded or linked)', 'style_b.d'));
		x.p('<dd>', x.a('<a>', 'include component with local none-repeated css rule', 'local_css_b.d'));
	
		x.p('<dt>', 'HTML page layout/reorder');
		x.p('<dd>', x.a('<a>', 'form V/H layouts', 'layout_b.form'));
		x.p('<dd>', x.a('<a>', 'reorder page components', 'layout_b.reorder'));
		x.p('<dd>', x.a('<a>', 'reorder style content to header', 'local_css_b.d?reorder=Y'));
		x.p('<dd>', x.a('<a>', 'use layout template', 'layout_b.use_layout'));
	
		x.p('<dt>', 'reports');
		x.p('<dd>', x.a('<a>', 'emp_managers(hierachical)', 'aggregation_b.emp_managers'));
		x.p('<dd>', x.a('<a>', 'emp_salaries(simple rollup)', 'aggregation_b.emp_salaries'));
		x.p('<dd>', x.a('<a>', 'emp_groups_list(complex rollup)', 'aggregation_b.emp_groups_list'));
		x.p('<dd>', x.a('<a>', 'job_dept_sals(cube)', 'aggregation_b.job_dept_sals'));
		x.p('<dd>', x.a('<a>', 'dept_job_sals(cube)', 'aggregation_b.dept_job_sals'));
	
		x.p('<dt>', 'charts');
		x.p('<dd>', x.a('<a>', 'salary min/max by job_id', 'chart_b.salary_min_max_by_job_id'));
		x.p('<dd>', x.a('<a>', 'salary share by job_id', 'chart_b.salary_share_by_job_id'));

		x.p('<dt>', 'icons');
		x.p('<dd>', x.a('<a>', 'material design icons', 'icon_b.material_design_icons'));
		x.p('<dd>', x.a('<a>', 'bootstrap_material_design', 'icon_b.bootstrap_material_design'));
		x.p('<dd>', x.a('<a>', 'ionicons', 'icon_b.ionicons'));

		x.p('<dt>', 'tables/grid/edit');
		x.p('<dd>', x.a('<a>', 'x-editable', 'tables_h.xeditable'));
		x.p('<dd>', x.a('<a>', 'handsontable', 'tables_h.handsontable'));
		x.p('<dd>', x.a('<a>', 'datatables', 'tables_h.datatables'));

		x.p('<dt>', 'charset_b');
		x.p('<dd>', x.a('<a>', 'form', 'charset_b.form'));
	
		x.p('<dt>', 'content negotiation');
		x.p('<dd>', x.a('<a>', 'lang_versions', 'negotiation_b.languages_by_browser'));
		x.p('<dd>', x.a('<a>', 'accepts_best_match', 'negotiation_b.accepts_best_match'));
	
		x.p('<dt>', 'user_b(show processing)');
		x.p('<dd>', x.a('<a>', 'register', 'user_b.register'));
	
		x.p('<dt>', 'error_b');
		x.p('<dd>', x.a('<a>', 'execute_with_error', 'error_b.execute_with_error'));
		x.p('<dd>', x.a('<a>', 'check_right', 'error_b.check_right'));
		x.p('<dd>', x.a('<a>', 'maybe_no_data', 'error_b.maybe_no_data'));
		x.p('<dd>', x.a('<a>', 'on_developing', 'error_b.on_developing'));
		x.p('<dd>', x.a('<a>', 'call_external', 'error_b.call_external'));
	
		x.p('<dt>', 'filter_b');
		x.p('<dd>', x.a('<a>', 'filter source', '=src_b.pack?p=k_filter'));
		x.p('<dd>', x.a('<a>', 'see_filter', 'filter_b.see_filter'));
	
		x.p('<dt>', 'session_b');
		x.p('<dd>', x.a('<a>', 'session login', 'session_b.login_form'));
	
		x.p('<dt>', 'term_b');
		x.p('<dd>', x.a('<a>', 'setting_form', 'term_b.setting_form'));
	
		x.p('<dt>', 'auth_b');
		x.p('<dd>', x.a('<a>', 'basic', 'auth_b.basic'));
		x.p('<dd>', x.a('<a>', 'digest', 'auth_b.digest'));
		x.p('<dd>', x.a('<a>', 'cookie_gac', 'auth_b.cookie_gac'));
		x.p('<dd>', x.a('<a>', 'protected_page', 'auth_b.protected_page'));
		x.p('<dd>', x.a('<a>', 'basic_and_cookie', 'auth_b.basic_and_cookie'));
	
		x.p('<dt', 'app modes');
		x.p('<dd>', x.a('<a target=_blank>', 'view packages', 'po_content_b.packages'));
		x.p('<dd>', x.a('<a target=_blank>', 'bootstrap', 'bootstrap_b.packages'));
		x.p('<dd>', x.a('<a target=_blank>', 'frameset container', 'po_frameset_b.main'));
		x.p('<dd>', x.a('<a target=_blank>', 'iframe container', 'po_iframe_b.main'));
		x.p('<dd>', x.a('<a target=_blank>', 'ajaxload containver', 'po_ajaxload_b.main'));
	
		x.p('<dt>', 'cache_b');
		x.p('<dd>', x.a('<a>', 'expires', 'cache_b.expires'));
		x.p('<dd>', x.a('<a>', 'last_modified', 'cache_b.last_modified'));
		x.p('<dd>', x.a('<a>', 'last_scn', 'cache_b.last_scn'));
		x.p('<dd>', x.a('<a>', 'etag_md5', 'cache_b.etag_md5'));
		x.p('<dd>', x.a('<a>', 'report_by_hour', 'cache_b.report_by_hour'));
	
		x.p('<dt>', 'proformance test');
		x.p('<dd>', x.a('<a>', 'output any kb', 'basic_io_b.any_size?size=10'));
		x.p('<dd>', x.a('<a>', 'css_prof_b', 'css_prof_b.main'));
		x.p('<dd>', x.a('<a>', 'empty html', 'performance_b.empty_html'));
		x.p('<dd>', x.a('<a>', 'no PL/SQL', '/_about'));
	
		x.p('<dt>', 'progressive HTML API(expr)');
		x.p('<dd>', x.a('<a>', 'alink demo', 'attr_tagp_demo_b.alink'));
	
		x.p('<dt>', 'xml_page_b');
		x.p('<dd>', x.a('<a>', 'xmlgen_str', 'xml_page_b.xmlgen_str'));
		x.p('<dd>', x.a('<a>', 'xmlgen_cur', 'xml_page_b.xmlgen_cur'));
		x.p('<dd>', x.a('<a>', 'xmlgen_hier', 'xml_page_b.xmlgen_hier'));
		x.p('<dd>', x.a('<a>', 'sql_users', 'xml_page_b.sql_users'));
		x.p('<dd>', x.a('<a>', 'xml_users_css', 'xml_page_b.xml_users_css'));
		x.p('<dd>', x.a('<a>', 'xml_users_xsl_cli', 'xml_page_b.xml_users_xsl_cli'));
	
		x.c('</dl>');
	end;

	procedure page is
	begin
		pc.h;
		x.p('<p>', 'The left frame is entrance to all the test pages');
	end;

end index_b;
/
