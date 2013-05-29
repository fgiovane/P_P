var processFooter = function(){
	$(".ft-trigger").click(function(){
		if (!$(this).hasClass("ft-active")){
			$(".ft-trigger").removeClass("ft-active");
			$(".ft-links").removeClass("ft-active");
			$(this).addClass("ft-active");
			$(this).parent().parent().find(".ft-links").addClass("ft-active");
		}
	});
};

var processActivities = function(){
	$.getJSON('ajax/activities.json', function(data){
		var items = [];
		
		$.each(data, function(key, val) {
		
			var itemContent = $('<div/>', {
				'class':'activity-content',
				html: val.message})
					.append($('<div/>', {
						'class' : 'activity-date',
						html: val.date
					}))
					.append($('<div/>', {
						'class' : 'activity-changed-by',
						html: 'Changed by ' + val.changed
					}));
			
			
			var item = $('<li/>', {
				'class':'activity-item',
				'data-activity-id': key,
				html: itemContent});
			
			items.push($(item).html());
		});
 
	  $('<ul/>', {
		'class': 'my-new-list',
		html: items.join('')
	  }).appendTo('.content');
		
	
	});
};


// this function is used to initialize page scripts
// is called by browsers and mobile (with or without jQuery Mobile)
var initPageScripts = function(){
	processFooter();
	processActivities();
};