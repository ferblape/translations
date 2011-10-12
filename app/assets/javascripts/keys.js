$(document).ready(function(){
	$('input#search').live("keyup click",function(){
		$.get("/search", {search: this.value});
	});

});