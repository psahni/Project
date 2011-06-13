jQuery(document).ready(function () {
		jQuery('.subnav').hide();
	jQuery('.hov a').hover(
		function () { jQuery('.subnav', this.parent).slideDown("slow"); },
		function () { jQuery('.subnav', this.parent).slideUp("slow"); });
});