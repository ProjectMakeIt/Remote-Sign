(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['slide-template.html'] = template({"compiler":[6,">= 2.0.0-beta.1"],"main":function(depth0,helpers,partials,data) {
    var helper, alias1=helpers.helperMissing, alias2="function", alias3=this.escapeExpression;

  return "<div class=\"slide\" data-id=\""
    + alias3(((helper = (helper = helpers._id || (depth0 != null ? depth0._id : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"_id","hash":{},"data":data}) : helper)))
    + "\">\n	<a href=\"javascript:void();\" onclick=\"window.removeSlide('"
    + alias3(((helper = (helper = helpers._id || (depth0 != null ? depth0._id : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"_id","hash":{},"data":data}) : helper)))
    + "')\" class=\"delete-slide\" id=\"close\">\n	</a>\n	<div class=\"screen-frame\">\n		<div class=\"screen-resolution\" height=\""
    + alias3(((helper = (helper = helpers.screenHeight || (depth0 != null ? depth0.screenHeight : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"screenHeight","hash":{},"data":data}) : helper)))
    + "\" width=\""
    + alias3(((helper = (helper = helpers.screenWidth || (depth0 != null ? depth0.screenWidth : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"screenWidth","hash":{},"data":data}) : helper)))
    + "\">\n			<img src=\""
    + alias3(((helper = (helper = helpers.url || (depth0 != null ? depth0.url : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"url","hash":{},"data":data}) : helper)))
    + "\" height=\""
    + alias3(((helper = (helper = helpers.imgHeight || (depth0 != null ? depth0.imgHeight : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"imgHeight","hash":{},"data":data}) : helper)))
    + "\" width=\""
    + alias3(((helper = (helper = helpers.imgWidth || (depth0 != null ? depth0.imgWidth : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"imgWidth","hash":{},"data":data}) : helper)))
    + "\"></img>\n		</div>\n	</div>\n</div>\n";
},"useData":true});
})();
