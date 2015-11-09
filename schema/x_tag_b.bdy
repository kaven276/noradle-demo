create or replace package body x_tag_b is

	procedure tags is
	begin
		src_b.header;
		x.p('<p>', 'note: open/close/pair/single');
		x.o('<div#container>');
		x.p(' <p>', 'open/close tag demo');
		x.s(' <input type=submit,value=single(self closed) tag>');
		x.c('</div>');
	end;

	procedure tag_attr is
	begin
		src_b.header;
		x.p('<p>', 'note: id/classes/nv attr/bool attr');
		x.p('<p#id>', '#id demo');
		x.p('<p.c1>', '.class demo');
		x.p('<p.c1.c2>', '.classes demo');
		x.p('<p#id.c1.c2>', '#id and .classes combined demo');
		x.p('<p attr1=value1>', 'single attr-value pair demo, " is not required to wrap value');
		x.p('<p attr1=value1,attr2=value2>', 'multiple attr-value pair(separated by ",") demo');
		x.p('<p ^attr=data>', 'html5 data-xxx attr(prefixed with "^") demo');
		x.p('<p disabled>', 'boolean attr demo');
		x.p('<p disabled readonly>', 'boolean attrs demo');
		x.p('<p#id.c1.c2 disabled readonly attr=value,^attr=data>', 'all in one demo');
	end;

	procedure url_link is
	begin
		src_b.header;
		x.p('<p>', 'note: link/script/form/a/img/base');
		x.b('<base>', '^');
		x.l('<link>', '[bootstrap.css]');
		x.j('<script>', '[jquery.js]');
		x.f('<form.container method=get>', '@b.url_link');
		x.p(' <p.alert.alert-info>', x.a('<a>', 'a link', '@b.url_link'));
		x.p(' <p.well>', x.i('<img alt=larry.jpg>', 'img/larry.jpg'));
		x.c('</form>');
	end;

	procedure form_item_value is
	begin
		src_b.header;
		x.p('<p>', 'note: bind plsql value to form item value attribute');
		x.v('<input type=pack>', r.getc('x$pack'));
		x.v('<input type=prog>', r.getc('x$proc'));
	end;

	procedure text is
	begin
		src_b.header;
		x.p('<p>', 'note: render/text/wrap/escape');
		x.p('<script>', x.r('prog="@";', r.getc('x$prog')));
		x.t('<script> alert(prog); </script>');
		x.t('<script> alert(":1"+"."+":2"); </script>', st(r.getc('x$pack'), r.getc('x$proc')));
		x.t('<style>
		  b:nth-child(2n){color:red;}
		  b:nth-child(2n+1){color:green;}
		     </style>');
		x.p('<p.word>', x.w('NORADLE'));
		x.p('<code>', x.e('<p>some html</p>'));
	end;

	procedure bool_attr is
	begin
	
		src_b.header;
		x.l('<link>', '[bootstrap.css]');
		x.p('<p.alert.alert-info>', 'info: b2c/checked/selected/disabled/readonly/defer/async');
		x.j('<script :1 :2>', '[jquery.js]', st(x.defer(true), x.async(true)));
	
		x.f('<form.container method=post>', r.prog);
	
		x.o(' <div.form-group>');
		x.p('  <label>', 'set-cookie name');
		x.o('  <select.form-control>');
		x.p('   <option :1>', 'value1', st(x.selected(false)));
		x.p('   <option :1>', 'value2', st(x.selected(true)));
		x.p('   <option :1>', 'value3', st(x.selected(false)));
		x.c('  </select>');
		x.c(' </div>');
	
		x.o(' <div.checkbox>');
		x.p('  <label>', x.s('<input :1 type=checkbox>', st(x.readonly(true))) || 'readonly');
		x.c(' </div>');
	
		x.o(' <div.checkbox>');
		x.p('  <label>', x.s('<input :1 type=checkbox>', st(x.disabled(true))) || 'disabled');
		x.c(' </div>');
	
		x.o(' <div.checkbox>');
		x.p('  <label>', x.s('<input :1 type=checkbox>', st(x.checked(true))) || 'checked');
		x.c(' </div>');
	
		x.s(' <input.btn.btn-primary type=submit>');
		x.c('</form>');
	end;

end x_tag_b;
/
