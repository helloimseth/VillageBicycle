VillageBicycle.Views.ListItemView = Backbone.View.extend({
  bikeTemplate: JST['bikes/bike_list_item'],

  requestTemplate: JST['requests/request_list_item'],

  tagName: 'article',

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var templatedListItem;

    if (this.model.urlRoot === "api/bikes") {
      templatedListItem = this.bikeTemplate({
        bike: this.model
      });
    } else {
      templatedListItem = this.requestTemplate({
        request: this.model
      });
    }

    this.$el.html(templatedListItem);

    return this;
  }
});
