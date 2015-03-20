VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: 'api/bikes',

  initialize: function () {
    this._extras = [];
  },

  grab: function (set, id_name) {
    return VillageBicycle.Sets.grab(set, this.get(id_name))
  },

  extras: function () {
    var extras = [];

    this.get("extra_ids").forEach(function (id) {
      extras.push(VillageBicycle.Sets.grab('extras', id))
    }.bind(this));

    return extras
  },

  toJSON: function () {
    return {user: _.clone(this.attributes)}
  }

});
