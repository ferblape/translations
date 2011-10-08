function fill_translation(tr){
	   $('#translation_translation').val(tr); 
}

$(document).ready(function(){
	$('.translated_list').click(function(e){
		fill_translation($(this).children('span').html());
		return false;
	});
});