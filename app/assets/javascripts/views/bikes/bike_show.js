VillageBicycle.Views.BikeShow = Backbone.View.extend({

  template: JST['bikes/show'],

  tagName: 'article',

  events: {
    'click #owner-link': 'navigateToOwnerShow',
    'click .edit-page': 'renderModal',
    'click .delete-model': 'renderModal',
    'click #request-button': 'renderModal'
  },

  initialize: function () {
    this._subviews = [];
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    this.geocodeAddress();

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
        address: this.model.get('address') + ' ' +
                 this.model.get('neighborhood') + ' ' +
                 "New York City"
      },
        this.attachMapView.bind(this)
    );
  },

  renderModal: function (event) {
    var modal;
    var model = this.model;

    if ($(event.currentTarget).hasClass('delete-model')){
      modal = new VillageBicycle.Views.DeleteModal({
        model: this.model
      });
    } else {

      if ($(event.currentTarget).attr('id') === "request-button") {
        model = new VillageBicycle.Models.Request({
          bike_id: this.model.id
        });
      }

      var modal = new VillageBicycle.Views.FormModal({
        model: model
      });
    }

    this._subviews.push(modal);

    this.$el.append(modal.render().$el)
  },

  navigateToOwnerShow: function (event) {
    Backbone.history.navigate("users/" + this.model.get('owner_id'), {
      trigger: true
    })
  },

  remove: function () {
    this._subviews.forEach(function(view){
      view.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }

});
