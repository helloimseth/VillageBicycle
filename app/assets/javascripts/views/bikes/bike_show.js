VillageBicycle.Views.BikeShow = Backbone.View.extend({

  template: JST['bikes/show'],

  tagName: 'article',

  events: {
    'click .edit-page': 'renderEditView',
    'click .delete-model': 'renderDeleteModal',
    'click #owner-link': 'navigateToOwnerShow'
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

  renderEditView: function () {
    var editModal = new VillageBicycle.Views.BikeForm({
      model: this.model
    });

    this._subviews.push(editModal);

    this.$el.append(editModal.render().$el)

  },

  renderDeleteModal: function () {
    var deleteModal = new VillageBicycle.Views.DeleteModal({
      model: this.model
    });

    this._subviews.push(deleteModal);

    this.$el.append(deleteModal.render().$el)
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
