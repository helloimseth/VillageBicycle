VillageBicycle.Views.BikeShowMap = Backbone.View.extend({

  initialize: function (options) {
    this.latlng = options.latlng;
  },

  render: function () {
    var mapOptions= {
      center: this.latlng,
      zoom: 15
    };

    this._map = new google.maps.Map(this.el, mapOptions)
    this._marker = new google.maps.Marker({
      position: this.latlng,
      map: this._map,
      title: this.model.get('address') + ' ' + this.model.get('neighborhood')
    })
  }

});
