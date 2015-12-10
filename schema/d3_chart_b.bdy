create or replace package body d3_chart_b is

  procedure try is
		begin
			x.t('<!DOCTYPE html>');
			x.o('<html>');
			x.o('<head>');
			x.j('<script>', '[d3.js]');
			x.t('<style>
			body>div {
			  background-color:steelblue;
				color: white;
				padding-top: 3px;
				padding-bottom: 3px;
				margin:5px 0px;
				text-align:right;
				padding-right:0.5em;
			}
			</style>');
			x.c('</head>');
			x.o('<body>');
			x.t('<script>
			var x=d3.scale.linear()
			 .domain([0,12])
			 .range([0,400])
			 ;
			d3.select("body").selectAll("div")
			 .data([2,3,5,7,11])
			 .enter().append("div")
			 .text(function(d,i){return d;})
			 .style("width", function(d,i){return x(d)+"px";})
			 ;
			</script>');
		end;

end d3_chart_b;
/
