create or replace package body icon_b is

	procedure material_design_icons is
	begin
		src_b.header;
		x.l('<link>', '[bcdn]material-design-icons/2.0.0/iconfont/style.min.css');
		x.p('<span.material-icons>', 'flower');
	end;

	procedure bootstrap_material_design is
	begin
		src_b.header;
		x.l('<link>', '[bootstrap.css]');
		x.l('<link>', '[bcdn]bootstrap-material-design/0.3.0/css/material.min.css');
		x.p('<button.btn.btn-material-deep-purple>', 'click me ' || x.p('<i.mdi-action-account-circle>', ''));
		x.p('<i.mdi-action-face-unlock style=font-size:40px;color:blue;>', '');
		x.p('<i.icon.icon-material-favorite>', '');
		x.j('<script>', '[jquery.js]');
		x.j('<script>', '[bcdn]bootstrap-material-design/0.3.0/js/material.min.js');
		x.p('<script>', '$.material.init();');
	end;

	procedure ionicons is
	begin
		src_b.header;
		x.l('<link>', '[bcdn]ionicons/2.0.1/css/ionicons.min.css');
		x.p('<style>', '.icon{font-size:40px;}');
		x.p('<i.icon.ion-home>', '');
		x.p('<i.icon.ion-ios-football>', '');
	end;

end icon_b;
/
