function fill_translation(tr){
	   $('#translation_translation').val(tr); //this puts the textarea for the id labeled 'area'
}

$(document).ready(function(){
	$('.translated_list').click(function(e){
		fill_translation($(this).html());
		return false;
	});
});