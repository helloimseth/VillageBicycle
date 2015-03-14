window.VillageBicycle = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    this.currentUserId = options.currentUserId
    new VillageBicycle.Routers.Router({
      $rootEl: options.$rootEl
    });
    Backbone.history.start();
  }
};
