VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: 'api/bikes',

  parse: function (response) {
    this.set(
      'size',
      VillageBicycle.Sets.grab('sizes', response.size_id)
    );

    delete response.owner; delete response.sizes;

    return response
  }
});
