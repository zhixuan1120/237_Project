jQuery(document).ready(function() {
	$('input#user_name').on("keyup input", function() {
		var input = $(this).val();
	
    	if(input.length > 0) {
        	$(this).after('<span class="checkmark valid_name"><div class="checkmark_circle"></div><div class="checkmark_stem"></div><div class="checkmark_kick"></div></span>');
    	} else {
    		$('.checkmark.valid_name').remove();
    	}
	});

	$('input#user_email').on("keyup input", function() {
        var input = $(this).val();
		var emailReg = /@uci\.edu/;
    	if(emailReg.test(input)) {
        	$(this).after('<span class="checkmark valid_email"><div class="checkmark_circle"></div><div class="checkmark_stem"></div><div class="checkmark_kick"></div></span>');
    	} else {
    		$('.checkmark.valid_email').remove();
    	}
	});

	$('input#user_password').on("keyup input", function() {
		var input = $(this).val();
        var passw = $('input#user_password_confirmation').val();

    	if(input.length > 5) {
        	$(this).after('<span class="checkmark valid_password"><div class="checkmark_circle"></div><div class="checkmark_stem"></div><div class="checkmark_kick"></div></span>');
            if (input == passw) {
                $(this).after('<span class="checkmark valid_confirm_password"><div class="checkmark_circle"></div><div class="checkmark_stem"></div><div class="checkmark_kick"></div></span>');
            } else {
                $('.checkmark.valid_confirm_password').remove();
            }
        } else {
    		$('.checkmark.valid_password').remove();
            $('.checkmark.valid_confirm_password').remove();
        }

	});

    $('input#user_password_confirmation').on("keyup input", function() {
        var input = $(this).val();
        var passw = $('input#user_password').val();
        
        if(input.length > 5 && input == passw) {
            $(this).after('<span class="checkmark valid_confirm_password"><div class="checkmark_circle"></div><div class="checkmark_stem"></div><div class="checkmark_kick"></div></span>');
        } else {
            $('.checkmark.valid_confirm_password').remove();
        }
    });
});
