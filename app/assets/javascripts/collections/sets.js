VillageBicycle.Models.Sets = Backbone.Model.extend({
  urlRoot: '/api/sets',

  parse: function (response) {
    console.log(response);
    this.categories = response.categories;
    delete response.categories;
    this.sizes = response.sizes;
    delete response.sizes;
    this.extras = response.extras;
    delete response.extras;
    this.neighborhoods = response.neighborhoods;
    delete response.neighborhoods;
    return response;
  }
})

VillageBicycle.Sets = new VillageBicycle.Models.Sets();
VillageBicycle.Sets.fetch()
