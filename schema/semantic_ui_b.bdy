create or replace package body semantic_ui_b is

	procedure three_buttons is
	begin
		o.t('<div#buttons.ui.three.buttons>');
		o.t(' <button.ui.button.active>', 'One');
		o.t(' <button.ui.button>', 'Two');
		o.t(' <button.ui.button>', 'Three');
		o.t('</div>');
	end;

	procedure select_dropdown is
	begin
		o.t('<select.ui.fluid.dropdown multiple name=countries>');
		for i in (select * from countries a) loop
			o.v('<option>', i.country_id, i.country_name);
		end loop;
		o.t('</select>');
		o.t('<script>', '$("select.dropdown").dropdown("set selected", ["BR", "AR"]);');
	end;

	procedure animate is
	begin
		b.l('<script>
		$("#buttons>button").transition({
			debug     : false,
			animation : "jiggle",
			duration  : 500,
			interval  : 200
		});
		</script>');
	end;

	procedure divider is
	begin
		o.t('<div.ui.three.column.middle.aligned.very.relaxed.grid>');
		o.t(' <div.column>', 'bootstrap');
		o.t(' <div.ui.vertical.divider>', 'OR');
		o.t(' <div.column>', 'semantic UI');
		o.t(' <div.ui.vertical.divider>', 'OR');
		o.t(' <div.column>', 'pure css');
		o.t('</div>');
	end;

	procedure dropdown_menu is
	begin
		o.t('<div#file_menu.ui.dropdown>');
		o.t(' <div.text>', 'File');
		o.t(' <i.dropdown.icon>', '');
		o.t(' <div.menu>');
		o.t('  <div.item>', 'New');
		o.t('  <div.item>', o.t('<span.description>', 'ctrl-o') || 'Open...');
		o.t('  <div.item>', o.t('<span.description>', 'ctrl-s') || 'Save...');
		o.t('  <div.item>', o.t('<span.description>', 'ctrl-r') || 'Rename...');
		o.t('  <div.item>', 'Make a copy');
		o.t('  <div.item>', o.t('<i.folder.icon>', '') || 'Move to folder');
		o.t('  <div.item>', o.t('<i.trash.icon>', '') || 'Move to trash');
		o.t('  <div.divider>', '');
		o.t('  <div.item>');
		o.t('   <i.dropdown.icon>', '');
		b.l('   publish to web');
		o.t('   <div.menu>');
		o.t('    <div.item>', 'Google Docs');
		o.t('    <div.item>', 'Google Drive');
		o.t('    <div.item>', 'Dropbox');
		o.t('   </div>');
		o.t('  </div>');
		o.t(' </div>');
		o.t('</div>');
		o.t('<script>', '$("#file_menu").dropdown()');
	end;

	procedure d is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[semantic.css]');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[semantic.js]', '');
		o.t('<h2>', o.u('<a target=_blank>', 'http://semantic-ui.com/', 'semantic-ui official site'));
		three_buttons;
		animate;
		select_dropdown;
		divider;
		dropdown_menu;
	end;

end semantic_ui_b;
/
