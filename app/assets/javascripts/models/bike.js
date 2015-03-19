VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: '/api/bikes',

  initialize: function () {
    this._extras = [];
  },

  grab: function (set, id_name) {
    return VillageBicycle.Sets.grab(set, this.get(id_name))
  },

  extras: function () {
    if (this._extras.length == 0){
      this.get("extra_ids").forEach(function (id) {
        this._extras.push(VillageBicycle.Sets.grab('extras', id))
      }.bind(this));
    }

    return this._extras
  }

});
