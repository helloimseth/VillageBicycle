VillageBicycle.Views.BikeShowMap = Backbone.View.extend({

  initialize: function (options) {
    this.latlng = options.latlng;
  },

  render: function () {
    var latLng = new google.maps.LatLng(
      this.model.get('latitude'),
      this.model.get('longitude')
    )

    var mapOptions= {
      center: latLng,
      zoom: 15
    };

    this._map = new google.maps.Map(this.el, mapOptions)



    this._marker = new google.maps.Marker({
      position: latLng,
      map: this._map,
      title: this.model.get('address') + ' ' + this.model.get('neighborhood')
    })

    return this;
  }

});
