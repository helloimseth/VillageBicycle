VillageBicycle.Views.QuickSearchView = Backbone.View.extend({
  template: JST['quick_search_view'],

  tagName: 'ul',

  render: function () {
    var templatedResults = this.template({
      results: this.collection
    });

    this.$el.html(templatedResults);

    return this;
  }
});
