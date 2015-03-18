VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: 'api/bikes',

  initialize: function () {
    this.attrs = {}
  },

  grab: function (set, id_name) {
    if (!this.attrs[set]) {
      this.attrs[set] = VillageBicycle.Sets.grab(set, this.get(id_name))
    }

    return this.attrs[set]
  }

});
