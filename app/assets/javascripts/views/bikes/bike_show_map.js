VillageBicycle.Views.MapView = Backbone.View.extend({

  initialize: function () {
    this._markers = {};
    this._setStyles();
  },

  renderSingleMap: function () {
    var latLng = new google.maps.LatLng(
      this.model.get('latitude'),
      this.model.get('longitude')
    )

    var styledMap = new google.maps.StyledMapType(this._styles, {
      name: "Styled Map"
    });

    var mapOptions= {
      center: latLng,
      zoom: 15,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
      }
    };

    this._map = new google.maps.Map(this.el, mapOptions)

    this._map.mapTypes.set('map_style', this.styledMap);
    this._map.setMapTypeId('map_style');

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
      zoom: 14,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
      }
    };

    this._map = new google.maps.Map(this.el, mapOptions)

    this._map.mapTypes.set('map_style', this.styledMap);
    this._map.setMapTypeId('map_style');

    this.collection.forEach(this.addMarker.bind(this))

    return this;
  },

  addMarker: function (bike) {
    var latLng = new google.maps.LatLng(
          bike.get('latitude'),
          bike.get('longitude')
        );

    var marker = new google.maps.Marker({
      position: latLng,
      map: this._map,
      title: bike.get('name') + " the " + bike.grab("categories", "category_id").name,
      icon: VillageBicycle.bicon
    });

    this._markers[bike.id] = marker;
  },

  _setStyles: function () {
    this._styles = [
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#444444"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "color": "#f2f2f2"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "all",
        "stylers": [
            {
                "color": "#cccccc"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#bb1244"
            },
            {
                "weight": "4.73"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "-94"
            },
            {
                "lightness": "95"
            },
            {
                "color": "#fefefe"
            },
            {
                "weight": "0.29"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "color": "#590920"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text",
        "stylers": [
            {
                "color": "#bb1124"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "color": "#870d31"
            },
            {
                "visibility": "on"
            }
        ]
    }
]

    this.styledMap = new google.maps.StyledMapType(this._styles, {
      name: "Styled Map"
    });
  }

});
