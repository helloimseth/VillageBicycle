VillageBicycle.Collections.Bikes = Backbone.Collection.extend({

  model: VillageBicycle.Models.Bike,

  url: 'api/bikes',

  getOrFetch: function (id) {
    var bike = this.find(id)

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

VillageBicycle.Collections.bikes = new VillageBicycle.Collections.Bikes()
