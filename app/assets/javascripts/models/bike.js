VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: 'api/bikes',

  owner: function () {
    if (!this._owner) {
      this._owner = VillageBicycle.Collections.users.getOrFetch(this.get('owner_id'));
    }

    return this._owner
  },

  parse: function (response) {
    this.owner().set(response.owner)

    this.set(
      'size',
      VillageBicycle.Sets.grab('sizes', response.size_id)
    );

    delete response.owner; delete response.sizes;

    return response
  }
});
