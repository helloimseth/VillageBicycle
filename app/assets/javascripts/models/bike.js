VillageBicycle.Models.Bike = Backbone.Model.extend({
  urlRoot: 'api/bikes',

  initialize: function () {
    this.size()
  },

  size: function () {
    if (!this._size) {
      this._size = VillageBicycle.Sets.grab("sizes", this.get('size_id'))
    }

    return this._size
  }
});
