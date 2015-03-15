VillageBicycle.Views.BikeShow = Backbone.View.extend({

  template: JST['bikes/show'],

  tagName: 'article',

  initialize: function () {
    this._subviews = [];
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.owner(), "sync", this.geocodeAddress)
  },

  render: function () {
    var templatedShow = this.template({
      bike: this.model
    });

    this.$el.html(templatedShow);

    return this;
  },

  attachMapView: function (results) {
    var mapView = new VillageBicycle.Views.BikeShowMap({
      el: document.getElementById('map-view'),
      latlng: results[0].geometry.location,
      model: this.model
    })

    this._subviews.push(mapView);

    mapView.render()
  },

  geocodeAddress: function () {
    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({
        address: this.model.owner().get('address') + ' ' +
                 this.model.get('neighborhood') + ' ' +
                 "New York City"
      },
        this.attachMapView.bind(this)
    );
  },

  remove: function () {
    this._subviews.forEach(function(view){
      view.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }

});
