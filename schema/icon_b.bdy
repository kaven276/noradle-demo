create or replace package body icon_b is

	procedure material_design_icons is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[bcdn]material-design-icons/2.0.0/iconfont/style.min.css');
		o.t('<span.material-icons>', 'face');
	end;

	procedure bootstrap_material_design is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[bootstrap.css]');
		o.u('<link rel=stylesheet/>', '[bcdn]bootstrap-material-design/0.3.0/css/material.min.css');
		o.t('<button.btn.btn-material-deep-purple>', 'click me ' || o.t('<i.mdi-action-account-circle>', ''));
		o.t('<i.mdi-action-face-unlock style="font-size:40px;color:blue;">', '');
		o.t('<i.icon.icon-material-favorite>', '');
		o.u('<script>', '[jquery.js]', '');
		o.u('<script>', '[bcdn]bootstrap-material-design/0.3.0/js/material.min.js', '');
		o.t('<script>', '$.material.init();');
	end;

	procedure ionicons is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[bcdn]ionicons/2.0.1/css/ionicons.min.css');
		o.t('<style>', '.icon{font-size:40px;}');
		o.t('<i.icon.ion-home>', '');
		o.t('<i.icon.ion-ios-football>', '');
	end;

end icon_b;
/
