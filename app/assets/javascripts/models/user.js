VillageBicycle.Models.User = Backbone.Model.extend({
  urlRoot: '/api/users',

  bikes: function () {
    if (!this._bikes) {
      this._bikes = new VillageBicycle.Collections.Bikes([], {
        owner: this
      });
    }

    return this._bikes;
  },

  parse: function (response) {
    if (response.bikes) {
      this.bikes().set(response.bikes);
      delete response.bikes;
    }

    return response
  }
});
