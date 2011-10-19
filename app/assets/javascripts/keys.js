$(document).ready(function(){
	$('input#search').live("keyup click",function(){
		$.get("keys", {search: this.value});
	});

});