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

    this.set('sizeId', response.size.id);
    this.set('suggestedHeight', response.size.suggested_height);

    this.set('categoryId', response.category.id)
    this.set('categoryName', response.category.name)

    this.extras = response.extras

    delete response.owner
    delete response.size
    delete response.category
    delete response.extras
    return response
  }
});
