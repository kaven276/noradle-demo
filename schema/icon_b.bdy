create or replace package body icon_b is

	procedure material_design_icons is
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[bcdn]material-design-icons/2.0.0/iconfont/style.min.css');
		j.t('<span.material-icons>', 'face');
	end;

	procedure bootstrap_material_design is
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[bootstrap.css]');
		j.u('<link rel=stylesheet/>', '[bcdn]bootstrap-material-design/0.3.0/css/material.min.css');
		j.t('<button.btn.btn-material-deep-purple>', 'click me ' || j.t('<i.mdi-action-account-circle>', ''));
		j.t('<i.mdi-action-face-unlock style="font-size:40px;color:blue;">', '');
		j.t('<i.icon.icon-material-favorite>', '');
		j.u('<script>', '[jquery.js]', '');
		j.u('<script>', '[bcdn]bootstrap-material-design/0.3.0/js/material.min.js', '');
		j.t('<script>', '$.material.init();');
	end;

	procedure ionicons is
	begin
		src_b.header;
		j.u('<link rel=stylesheet/>', '[bcdn]ionicons/2.0.1/css/ionicons.min.css');
		j.t('<style>', '.icon{font-size:40px;}');
		j.t('<i.icon.ion-home>', '');
		j.t('<i.icon.ion-ios-football>', '');
	end;

end icon_b;
/
