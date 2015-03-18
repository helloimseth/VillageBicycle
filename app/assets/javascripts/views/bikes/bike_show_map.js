VillageBicycle.Views.MapView = Backbone.View.extend({

  initialize: function () {
    this._markers = {};
  },

  renderSingleMap: function () {
    var latLng = new google.maps.LatLng(
      this.model.get('latitude'),
      this.model.get('longitude')
    )

    var mapOptions= {
      center: latLng,
      zoom: 15
    };

    this._map = new google.maps.Map(this.el, mapOptions)

    this.addMarker(this.model)

    return this;
  },

  renderResultsMap: function () {
    var centerLatLng = new google.maps.LatLng(
      40.7127837,
      -74.0059413
    )

    var mapOptions= {
      center: centerLatLng,
      zoom: 12
    };

    this._map = new google.maps.Map(this.el, mapOptions)

    this.collection.forEach(this.addMarker.bind(this))
  },

  addMarker: function (bike) {
    var latLng = new google.maps.LatLng(
          bike.get('latitude'),
          bike.get('longitude')
        );

    var marker = new google.maps.Marker({
      position: latLng,
      map: this._map,
      title: bike.get('name') + " the " + bike.get('type')
    })

    this._markers[bike.id] = marker;
  }

});
