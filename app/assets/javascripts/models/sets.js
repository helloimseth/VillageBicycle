VillageBicycle.Models.Sets = Backbone.Model.extend({
  urlRoot: '/api/sets',

  parse: function (response) {
    this.set('categories', response.categories);
    delete response.categories;
    this.set('sizes', response.sizes);
    delete response.sizes;
    this.set('extras', response.extras);
    delete response.extras;
    this.set('neighborhoods', response.neighborhoods);
    delete response.neighborhoods;
    return response;
  },

  grab: function(collection, id) {
    var a = this.get(collection);
    return _.find(a, function (obj) { return obj.id === id });
  }
})

VillageBicycle.Sets = new VillageBicycle.Models.Sets();
VillageBicycle.Sets.fetch()
