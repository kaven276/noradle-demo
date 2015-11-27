create or replace package body po_ajaxload_b is

	procedure main is
	begin
		x.t('<DOCTYPE html>');
		x.o('<html>');
		x.o(' <head>');
		x.s('  <base target=_blank>');
		x.s('  <meta name=viewport,content=:1>', st('width=device-width, initial-scale=1'));
		x.l('  <link>', '[bootstrap.css]');
		x.j('  <script>', '[jquery.js]');
		x.j('  <script>', '[bootstrap.js]');
		x.p('  <script>', '$(function(){
		$("body").on("click","a",function(e){
		  console.log($(this).attr("href"));
		  $("body").load($(this).attr("href"));
			e.preventDefault();
      e.stopPropagation();
		});
		$(document.body).load("po_content_b.packages");
		})');
		x.c(' </head>');
		x.p(' <body>', '');
		x.c('</html>');
	end;

end po_ajaxload_b;
/
