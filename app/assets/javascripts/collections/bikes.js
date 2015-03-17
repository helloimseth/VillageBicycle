VillageBicycle.Collections.Bikes = Backbone.Collection.extend({

  model: VillageBicycle.Models.Bike,

  url: "/api/bikes",

  getOrFetch: function (id) {
    var bike = this.get(id)

    if (!bike) {
      bike = new VillageBicycle.Models.Bike({
        id: id
      });

      this.add(bike);
    }

    bike.fetch();

    return bike;
  }

});
