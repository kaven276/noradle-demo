create or replace package body ng_nvd3_b is

	procedure d is
	begin
		src_b.header;
		o.u('<link rel=stylesheet/>', '[nv.d3.css]');
		o.u('<script>', '[angular.js]', '');
		o.u('<script>', '[d3.js]', '');
		o.u('<script>', '[nv.d3.js]', '');
		o.u('<script>', '[ng-nvd3.js]', '');
		o.t('<h2>',
				o.u('<a target=_blank>',
						'https://github.com/angularjs-nvd3-directives/angularjs-nvd3-directives',
						'angularjs-nvd3-directives official site'));
		o.u('<script>', '*.js', '');
		o.t('<div ng-app=nvd3TestApp ng-controller=ExampleCtl>');
		o.t(' <nvd3-line-chart showXAxis showYAxis tooltips interactive data=exampleData>', '');
		o.t('</div>');
	end;

end ng_nvd3_b;
/
