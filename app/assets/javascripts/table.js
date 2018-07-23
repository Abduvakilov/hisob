function table($, undefined) {
    "use strict";

	$("*[data-url]").click(function() {
	  Turbolinks.visit($(this).data("url"));
	})

}