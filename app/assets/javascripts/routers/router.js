VillageBicycle.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "userShow",
    "bikes/search": "bikeSearch",
    "bikes/:id": "bikeShow",
    "users/:id": "userShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.addHeader();
  },

  bikeShow: function (id) {
    var bike = new VillageBicycle.Models.Bike({
      id: id
    });

    var bikeShow = new VillageBicycle.Views.BikeShow({
      model: bike
    });

    bike.fetch({
      success: this.swapView.bind(this, bikeShow)
    });
  },

  bikeSearch: function () {
    var bikeSearch = new VillageBicycle.Views.BikeSearch();

    this.swapView(bikeSearch);
  },

  userShow: function (id) {
    if (!id) { id = VillageBicycle.currentUserId }

    var user = new VillageBicycle.Models.User({
      id: id
    });

    var userShow = new VillageBicycle.Views.UserShow({
      model: user
    });

    user.fetch({
      success: this.swapView.bind(this, userShow)
    });
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.$el)
    view.render()
  },

  addHeader: function () {
    var header = new VillageBicycle.Views.Header();

    this.$rootEl.before(header.render().$el);
  }


});
