create or replace package body index_b is

	procedure frame is
	begin
		b.l('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">');
		o.t('<html>');
		o.t('<head>');
		o.t(' <title>', 'PSP.WEB test/demo suite');
		o.t('</head>');
		o.t('<frameset cols=280,* frameborder=yes>');
		o.p(1, 'border-right:1px solid gray;overflow-y:scroll;');
		o.u(' <frame name=dir scrolling=true style=?>', '@b.dir');
		o.u(' <frame name=page>', '@b.page');
		o.t('</frameset>');
		o.t('</html>');
	end;

	procedure dir is
		hd1 varchar2(100) := '<span class="handle glyphicon glyphicon-triangle-right"></span>';
		hd2 varchar2(100) := '<span class="handle glyphicon glyphicon-unchecked"></span>';
	begin
		pc.h(target => 'page');
		x.t('<style>html{background:url(:1)}</style>', st(l('^img/subtle_freckles.png')));
		x.l('<link>', '[bootstrap.css]');
		x.j('<script>', '[jquery.js]');
		x.j('<script>', '[bootstrap.js]');
		x.l('<link>', '@b/tree.css');
		x.j('<script>', '@b/tree.js');
		x.o('<div.root.container-fluid>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'ora_good_b'));
		x.o('<div.branch.collapse>');
		x.p(' <div.node>', hd2 || x.a('<a>', 'introduce', 'ora_good_b.entry'));
		x.c('</div>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'basic input output'));
		x.o('<div.branch.collapse>');
		x.p(' <div.node>', hd2 || x.a('<a>', 'req_info', 'basic_io_b.req_info'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'output', 'basic_io_b.output'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'parameters', 'basic_io_b.parameters'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'keep_urlencoded', 'basic_io_b.keep_urlencoded'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'steps', 'basic_io_b.steps'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'if appended', 'basic_io_b.appended'));
		x.c('</div>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'output orgnization'));
		x.o('<div.branch.collapse>');
		x.p(' <div.node>', hd2 || x.a('<a>', 'bind data in html', 'html_b.bind_data'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'regen_page', 'html_b.regen_page'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'component', 'html_b.component'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'complex', 'html_b.complex'));
		x.c('</div>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'post/upload file'));
		x.o('<div.branch.collapse>');
		x.p(' <div.node>', hd2 || x.a('<a>', 'upload_form', 'post_file_b.upload_form'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'ajax_post', 'post_file_b.ajax_post'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'post json', 'post_file_b.ajax_post_json'));
		x.p(' <div.node>', hd2 || x.a('<a>', 'media capture', 'media_b.file_image'));
		x.c('</div>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'control by http response headers'));
		begin
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'gzip', 'http_b.gzip'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'chunked_transfer', 'http_b.chunked_transfer'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'long_job', 'http_b.long_job'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'content_type', 'http_b.content_type'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'refresh to self', 'http_b.refresh'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'refresh to other', 'http_b.refresh?to=index_b.page'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'content_md5', 'http_b.content_md5'));
			x.p(' <div.node>', hd1 || x.p('<b>', 'mimic file download'));
			x.o(' <div.branch.collapse>');
			x.p('  <div.node>', hd2 || x.a('<a>', 'd', 'file_dl_b.d'));
			x.p('  <div.node>', hd2 || x.a('<a>', 'text', 'file_dl_b.text'));
			x.p('  <div.node>', hd2 || x.a('<a>', 'excel', 'file_dl_b.excel'));
			x.p('  <div.node>', hd2 || x.a('<a>', 'word', 'file_dl_b.excel'));
			x.c(' </div>');
			x.p(' <div.node>', hd1 || x.p('<b>', 'about cookie'));
			x.o(' <div.branch.collapse>');
			x.p('  <div.node>', hd2 || x.a('<a>', 'set/view cookie', 'cookie_h.form_view'));
			x.c(' </div>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'charset', 'charset_b.form'));
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'data service: resultsets print'));
		begin
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'resultset demo list', 'src_b.proc_list?pack=db_src_b'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example', 'db_src_b.basic?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example(jade)', 'db_src_b.basic?template=test.jade'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example(mustache)', 'db_src_b.basic?template=test.mst'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example(handlebars)', 'db_src_b.basic?template=test.hbs'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example(swig)', 'db_src_b.basic?template=test.swig'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'example(ejs)', 'db_src_b.basic?template=test.ejs'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'scalar data types(SQL)', 'db_src_b.scalars_sql?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'scalar data types(API)', 'db_src_b.scalars_direct?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'scalar array', 'db_src_b.scalar_array?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parent-children data', 'db_src_b.pack_proc?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'key-value', 'db_src_b.pack_kv?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'key-value(child)', 'db_src_b.pack_kv_child?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'direct_json', 'db_src_b.direct_json?inspect&markdown'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'set_mime_no_convert', 'db_src_b.set_mime_no_convert?inspect&markdown'));
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'page service: html/xml print'));
		begin
			x.o('<div.branch.collapse>');
			x.p('<div.node>', hd1 || x.p('<b>', 'x(tag) print'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'tags', 'x_tag_b.tags'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'tag_attr', 'x_tag_b.tag_attr'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'url_link', 'x_tag_b.url_link'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'form_item_value', 'x_tag_b.form_item_value'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'text', 'x_tag_b.text'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'bool_attr', 'x_tag_b.bool_attr'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'm(multi) print'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'wrap_each_array_value', 'm_multi_b.wrap_each_array_value'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'wrap_array_in_loop', 'm_multi_b.wrap_array_in_loop'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_render_st', 'm_multi_b.parse_render_st'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_render_st_boolean', 'm_multi_b.parse_render_st_boolean'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_render_cursor', 'm_multi_b.parse_render_cursor'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'nv_form_select_options', 'm_multi_b.nv_form_select_options'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'nv_form_radios', 'm_multi_b.nv_form_radios'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'nv_form_checkboxes', 'm_multi_b.nv_form_checkboxes'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'tr(tree) printing'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_render_in_loop', 'tree_b.parse_render_in_loop'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_open_render_cur_close', 'tree_b.parse_open_render_cur_close'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'parse_render_cur_united', 'tree_b.parse_render_cur_united'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'hier_node_level_in_loop', 'tree_b.hier_node_level_in_loop'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'hier_node_all_types', 'tree_b.hier_node_all_types'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'tb(table) formating/printing'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'for loop print', 'list_b.user_objects'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'multi.c print', 'list_b.user_objects_cur'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'sys_refcursor print', 'list_b.user_procedures'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'l(link) to url'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'link demo list', 'src_b.proc_list?pack=easy_url_b'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_transparent', 'easy_url_b.link_transparent'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_equal_to', 'easy_url_b.link_equal_to'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_proc_in_same_pack', 'easy_url_b.link_proc_in_same_pack'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_proc_in_any_pack', 'easy_url_b.link_proc_in_any_pack'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_standalone_proc', 'easy_url_b.link_standalone_proc'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_static_for_site', 'easy_url_b.link_static_for_site'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_static_for_pack', 'easy_url_b.link_static_for_pack'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_static_for_me', 'easy_url_b.link_static_for_me'));
			x.p(' <div.node>',
					hd2 || x.a('<a>', 'link_other_parallel_app_static', 'easy_url_b.link_other_parallel_app_static'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'link_configured_url', 'easy_url_b.link_configured_url'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'use_base_url_for_static', 'easy_url_b.use_base_url_for_static'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'all patterns', 'easy_url_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'links in standalone procedure', './url_test1_b'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'param use t.ps and tmp.stv', 'easy_url_b.param_use_stv'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'param interpolate', 'easy_url_b.param_interpolate'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'param use vqstr', 'easy_url_b.param_use_vqstr'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'param tail', 'easy_url_b.param_tail'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'param interpolate&tail', 'easy_url_b.param_interpolate_tail'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'url relay', 'easy_url_b.url_relay'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'css related'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'component_css?link=Y', 'html_b.component_css?link=Y'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'component_css?link=N', 'html_b.component_css?link=N'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'css in HTML API(embeded or linked)', 'style_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'include component with local none-repeated css rule', 'local_css_b.d'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'HTML page layout/reorder'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'form V/H layouts', 'layout_b.form'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'reorder page components', 'layout_b.reorder'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'reorder style content to header', 'local_css_b.d?reorder=Y'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'use layout template', 'layout_b.use_layout'));
			x.c('</div>');
		
			x.c('</div>');
		end;
	
		-- advanced part
		x.p('<div.node>', hd1 || x.p('<b>', 'servlet execution flow control'));
		begin
			x.o('<div.branch.collapse>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'virtual host'));
		
			x.p('<div.node>', hd1 || x.p('<b>', 'content negotiation'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'lang_versions', 'negotiation_b.languages_by_browser'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'accepts_best_match', 'negotiation_b.accepts_best_match'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'form post / feedback'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'user (un)register', 'user_b.register'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'error raise/catch/process'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'execute_with_error', 'error_b.execute_with_error'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'check_right', 'error_b.check_right'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'maybe_no_data', 'error_b.maybe_no_data'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'on_developing', 'error_b.on_developing'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'call_external', 'error_b.call_external'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'before/after filter'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'filter source', '=src_b.pack?p=k_filter'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'see_filter', 'filter_b.see_filter'));
			x.c('</div>');
		
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'session / authentication'));
		begin
			x.o('<div.branch.collapse>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'session_b'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'session login', 'session_b.login_form'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'term_b'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'setting_form', 'term_b.setting_form'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'auth_b'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'basic', 'auth_b.basic'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'digest', 'auth_b.digest'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'cookie_gac', 'auth_b.cookie_gac'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'protected_page', 'auth_b.protected_page'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'basic_and_cookie', 'auth_b.basic_and_cookie'));
			x.c('</div>');
		
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'app modes'));
		x.o('<div.branch.collapse>');
		x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'view packages', 'po_content_b.packages'));
		x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'bootstrap', 'bootstrap_b.packages'));
		x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'frameset container', 'po_frameset_b.main'));
		x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'iframe container', 'po_iframe_b.main'));
		x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'ajaxload containver', 'po_ajaxload_b.main'));
		x.c('</div>');
	
		x.p('<div.node>', hd1 || x.p('<b>', 'oracle xml/json support'));
		begin
			x.o('<div.branch.collapse>');
			x.p('<div.node>', hd1 || x.p('<b>', 'oracle xml'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'xmlgen_str', 'xml_page_b.xmlgen_str'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'xmlgen_cur', 'xml_page_b.xmlgen_cur'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'xmlgen_hier', 'xml_page_b.xmlgen_hier'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'sql_users', 'xml_page_b.sql_users'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'xml_users_css', 'xml_page_b.xml_users_css'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'xml_users_xsl_cli', 'xml_page_b.xml_users_xsl_cli'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'oracle json'));
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'advanced SQL'));
		begin
			x.o('<div.branch.collapse>');
			x.p('<div.node>', hd1 || x.p('<b>', 'reports'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'emp_managers(hierachical)', 'aggregation_b.emp_managers'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'emp_salaries(simple rollup)', 'aggregation_b.emp_salaries'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'emp_groups_list(complex rollup)', 'aggregation_b.emp_groups_list'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'job_dept_sals(cube)', 'aggregation_b.job_dept_sals'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'dept_job_sals(cube)', 'aggregation_b.dept_job_sals'));
			x.c('</div>');
			x.p('<div.node>', hd1 || x.p('<b>', 'analytic SQL'));
			x.p('<div.node>', hd1 || x.p('<b>', 'datawarehouse SQL'));
			x.p('<div.node>', hd1 || x.p('<b>', 'statictic SQL'));
			x.p('<div.node>', hd1 || x.p('<b>', 'OLAP'));
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', '3rd-party js/css lib integration'));
		begin
			x.o('<div.branch.collapse>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'UI lib'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'bootstrap', 'bootstrap_b.packages'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'semantic UI', 'semantic_ui_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'purecss', 'purecss_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'jQuery ui', 'jquery_ui_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'jQuery mobile', 'jquery_mobile_b.d'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'chart'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd1 || x.p('<b>', 'chart.js'));
			x.o('  <div.branch.collapse>');
			x.p('   <div.node>', hd2 || x.a('<a>', 'salary min/max by job_id', 'chart_b.salary_min_max_by_job_id'));
			x.p('   <div.node>', hd2 || x.a('<a>', 'salary share by job_id', 'chart_b.salary_share_by_job_id'));
			x.c('  </div>');
			x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'd3', 'https://github.com/mbostock/d3/wiki/Gallery'));
			x.p(' <div.node>', hd2 || x.a('<a target=_blank>', 'hcharts', 'http://www.hcharts.cn/'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'highcharts', 'highcharts_b.d'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'ng-nvd3', 'ng_nvd3_b.d'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'icons'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'material design icons', 'icon_b.material_design_icons'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'bootstrap_material_design', 'icon_b.bootstrap_material_design'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'ionicons', 'icon_b.ionicons'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'tables/grid/edit'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'x-editable', 'tables_h.xeditable'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'handsontable', 'tables_h.handsontable'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'datatables', 'tables_h.datatables'));
			x.c('</div>');
		
			x.c('</div>');
		end;
	
		x.p('<div.node>', hd1 || x.p('<b>', 'none functional'));
		begin
			x.o('<div.branch.collapse>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'client/gateway cache'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'expires', 'cache_b.expires'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'last_modified', 'cache_b.last_modified'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'last_scn', 'cache_b.last_scn'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'etag_md5', 'cache_b.etag_md5'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'report_by_hour', 'cache_b.report_by_hour'));
			x.c('</div>');
		
			x.p('<div.node>', hd1 || x.p('<b>', 'proformance test'));
			x.o('<div.branch.collapse>');
			x.p(' <div.node>', hd2 || x.a('<a>', 'output any kb', 'basic_io_b.any_size?size=10'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'css_prof_b', 'css_prof_b.main'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'empty html', 'performance_b.empty_html'));
			x.p(' <div.node>', hd2 || x.a('<a>', 'no PL/SQL', '/_about'));
			x.c('</div>');
			x.c('</div>');
		end;
	
	end;

	procedure page is
	begin
		pc.h;
		x.p('<p>', 'The left frame is entrance to all the test pages');
	end;

end index_b;
/
