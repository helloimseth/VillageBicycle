window.VillageBicycle = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(options) {
    this.currentUserId = options.currentUserId

    this.Sets = new VillageBicycle.Models.Sets();
    this.Sets.fetch()

    new VillageBicycle.Routers.Router({
      $rootEl: options.$rootEl
    });

    Backbone.history.start();
  }
};
