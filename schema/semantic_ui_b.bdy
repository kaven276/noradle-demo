create or replace package body semantic_ui_b is

	procedure three_buttons is
	begin
		j.t('<div#buttons.ui.three.buttons>');
		j.t(' <button.ui.button.active>', 'One');
		j.t(' <button.ui.button>', 'Two');
		j.t(' <button.ui.button>', 'Three');
		j.t('</div>');
	end;

	procedure select_dropdown is
	begin
		j.t('<select.ui.fluid.dropdown multiple name=countries>');
		for i in (select * from countries a) loop
			j.v('<option>', i.country_id, i.country_name);
		end loop;
		j.t('</select>');
		j.t('<script>', '$("select.dropdown").dropdown("set selected", ["BR", "AR"]);');
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
		j.t('<div.ui.three.column.middle.aligned.very.relaxed.grid>');
		j.t(' <div.column>', 'bootstrap');
		j.t(' <div.ui.vertical.divider>', 'OR');
		j.t(' <div.column>', 'semantic UI');
		j.t(' <div.ui.vertical.divider>', 'OR');
		j.t(' <div.column>', 'pure css');
		j.t('</div>');
	end;

	procedure dropdown_menu is
	begin
		j.t('<div#file_menu.ui.dropdown>');
		j.t(' <div.text>', 'File');
		j.t(' <i.dropdown.icon>', '');
		j.t(' <div.menu>');
		j.t('  <div.item>', 'New');
		j.t('  <div.item>', j.t('<span.description>', 'ctrl-o') || 'Open...');
		j.t('  <div.item>', j.t('<span.description>', 'ctrl-s') || 'Save...');
		j.t('  <div.item>', j.t('<span.description>', 'ctrl-r') || 'Rename...');
		j.t('  <div.item>', 'Make a copy');
		j.t('  <div.item>', j.t('<i.folder.icon>', '') || 'Move to folder');
		j.t('  <div.item>', j.t('<i.trash.icon>', '') || 'Move to trash');
		j.t('  <div.divider>', '');
		j.t('  <div.item>');
		j.t('   <i.dropdown.icon>', '');
		b.l('   publish to web');
		j.t('   <div.menu>');
		j.t('    <div.item>', 'Google Docs');
		j.t('    <div.item>', 'Google Drive');
		j.t('    <div.item>', 'Dropbox');
		j.t('   </div>');
		j.t('  </div>');
		j.t(' </div>');
		j.t('</div>');
		j.t('<script>', '$("#file_menu").dropdown()');
	end;

	procedure d is
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[semantic.css]');
		j.u('<script>', '[jquery.js]', '');
		j.u('<script>', '[semantic.js]', '');
		j.t('<h2>', j.u('<a target=_blank>', 'http://semantic-ui.com/', 'semantic-ui official site'));
		three_buttons;
		animate;
		select_dropdown;
		divider;
		dropdown_menu;
	end;

end semantic_ui_b;
/
