VillageBicycle.Views.BikeShow = Backbone.View.extend({

  template: JST['bikes/show'],

  tagName: 'article',

  initialize: function () {
    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({
      //UNABLE TO READ STREET ADDRESS - TROUBLE SHOOT THIS FIRST
      address: this.model.owner().get('address') + ' ' + this.model.get('neighborhood')
    }, this.attachMapView.bind(this))

    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var templatedShow = this.template({
      bike: this.model
    });

    this.$el.html(templatedShow);

    return this;
  },

  attachMapView: function (results) {
    console.log(results);
    var mapsView = new VillageBicycle.Views.BikeMapShow({
      latlng: results[0].geometry.location
    })

    mapsView.render()
  }

});
