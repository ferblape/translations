function fill_translation(tr){
	   $('#translation_translation').val(tr); 
}

$(document).ready(function(){
	$('.whole-translation').click(function(e){
		fill_translation($(this).children('span').html());
		return false;
	});
});