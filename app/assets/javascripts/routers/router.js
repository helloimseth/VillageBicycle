VillageBicycle.Routers.Router = Backbone.Router.extend({
  routes: {
    "bikes/:id": "bikeShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  bikeShow: function (id) {
    var bike = VillageBicycle.Collections.bikes.getOrFetch(id)

    var showView = new VillageBicycle.Views.BikeShow({
      model: bike
    });

    this.swapView(showView);
  },

  swapView: function (view) {
    this._currentView && this.currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el)
  }


});
