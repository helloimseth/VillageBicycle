VillageBicycle.Collections.QuickSearchResults = Backbone.Collection.extend({
  url: '/api/quick_searches?query=',

  model: function (attrs, options) {
    if (attrs.category_id) {
      return new VillageBicycle.Models.Bike(attrs, options)
    } else {
      return new VillageBicycle.Models.User(attrs, options)
    }
  }
});
