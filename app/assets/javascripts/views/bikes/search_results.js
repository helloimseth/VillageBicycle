VillageBicycle.Views.SearchResults = Backbone.View.extend({
  template: JST['bikes/search_results'],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function () {
    var templatedResults = this.template();

    this.$el.html(templatedResults);
    this.attachBikeList();

    return this;
  },

  attachBikeList: function () {
    this.bikeList = new VillageBicycle.Views.BikeListView({
      collection: this.collection
    });

    this.$el.find('#search-results').append(this.bikeList.render().$el);
  },

  remove: function () {
    this.bikeList && this.bikeList.remove();
    Backbone.View.prototype.remove.call(this);
  }
});
