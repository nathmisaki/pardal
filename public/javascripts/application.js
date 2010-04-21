// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
    $("#help_link a[rel]").overlay({
      expose: 'darkblue',
      effect: 'apple',

      onBeforeLoad: function() {

        // grab wrapper element inside content
        var wrap = this.getContent().find(".contentWrap");

        // load the page specified in the trigger
        wrap.load(this.getTrigger().attr("href"));
      }

    });
});
