VillageBicycle.Views.BikeMapShow = Backbone.View.extend({

  attributes: {
    id: 'map-view'
  },

  initialize: function (options) {
    this.latlng = options.latlng;
  },

  render: function () {
    console.log(this.latlng);
    var mapOptions= {
      center: { lat: this.latlng.lat(), lng: this.latlng.lng() },
      zoom: 8
    };

    this._map = new google.maps.Map(this.el, mapOptions)

  }

});
