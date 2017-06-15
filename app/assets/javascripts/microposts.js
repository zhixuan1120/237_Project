function updateCountdown()
{
	var remaining = 500 - jQuery('#micropost_content').val().length;
	jQuery('.countdown').text(remaining + ' character(s) remaining');
}

function checkEmptyField()
{
	$("[name=commit]").first().attr('disabled', true);
}

//scrollTop() return the position of first matched element in pixels
//position is the same as the number of pixels that are hidden from view above the scrollable area

//$(window).height() returns height of browser viewpoint
//$(window).height() returns height of HTML document

function fetch() {
	
	// $(window).scrollTop() tells us how far from the top of the page the user has scrolled
	// $(document).height() - $(window).height() is a fixed value.
	// when $(window).scrollTop() == $(document).height() - $(window).height(), user reached the bottom of page.
	// So add a 50-pixels buffer zone so that event will be triggered when user scroll almost to the bottom
	var url = $('.pagination .next.next_page > a').attr('href');
	
	if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 200) {
		// getScript(URL, callback) loads a JavaScript file from server using a GET HTTP request, then execute it.
      
        //$('.pagination .next') looks for all elements with .next class that also have an element with
        //the .pagination class as an ancestor.

		// NOTE: space is IMPORTANT here, so $('.pagination .next') is different from $('.pagination.next')
		// $('.pagination.next') finds the element with both ".next" and ".pagination" class.
		$('.pagination').text("Loading more posts...");
		$.getScript(url);
	}

}

function endlessPage() {
	$(window).scroll(fetch);
}

jQuery(document).ready(function() {
	updateCountdown();
	
	$('#micropost_content').keyup(updateCountdown);

	endlessPage();

});
