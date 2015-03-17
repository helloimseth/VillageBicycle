VillageBicycle.Routers.Router = Backbone.Router.extend({
  routes: {
    "bikes/search": "bikeSearch",
    "bikes/:id": "bikeShow",
    "users/:id": "userShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  bikeShow: function (id) {
    var bike = new VillageBicycle.Models.Bike({
      id: id
    });
    bike.fetch();

    var bikeShow = new VillageBicycle.Views.BikeShow({
      model: bike
    });

    this.swapView(bikeShow);
  },

  bikeSearch: function () {
    var bikeSearch = new VillageBicycle.Views.BikeSearch();

    this.swapView(bikeSearch);
  },

  userShow: function (id) {
    var user = new VillageBicycle.Models.User({
      id: id
    });

    user.fetch();

    var userShow = new VillageBicycle.Views.UserShow({
      model: user
    });

    this.swapView(userShow);
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.$el)
    view.render()
  }


});
