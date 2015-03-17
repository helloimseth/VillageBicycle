VillageBicycle.Views.SearchResults = Backbone.View.extend({
  template: JST['bikes/search_results'],


  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function () {
    var templatedResults = this.template({
      bikes: this.collection
    });

    this.$el.html(templatedResults);


    return this;
  },

});
