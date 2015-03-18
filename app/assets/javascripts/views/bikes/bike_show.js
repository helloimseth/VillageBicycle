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
    
    var templatedShow = this.template({
      bike: this.model
    });

    this.$el.html(templatedShow);

    this.attachMapView();

    return this;
  },

  attachMapView: function () {
    var mapView = new VillageBicycle.Views.MapView({
      el: document.getElementById('map-view'),
      model: this.model
    })

    this._subviews.push(mapView);

    mapView.renderSingleMap()
  },

  renderModal: function (event) {
    var modal;

    if ($(event.currentTarget).hasClass('delete-model')){
      modal = new VillageBicycle.Views.DeleteModal({
        model: this.model
      });
    } else {
      var modal = new VillageBicycle.Views.FormModal({
        model: this._requestOrBikeFromEvent(event)
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
  },

  _requestOrBikeFromEvent: function (event) {
    var model = this.model;

    if ($(event.currentTarget).attr('id') === "request-button") {
      model = new VillageBicycle.Models.Request({
        bike_id: this.model.id
      });
    }

    return model;
  }

});
