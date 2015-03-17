VillageBicycle.Views.BikeListItemView = Backbone.View.extend({
  template: JST['bikes/bike_list_item'],

  tagName: 'article',

  render: function () {
    var templatedListItem = this.template({
      bike: this.model
    });

    this.$el.html(templatedListItem);

    return this;
  }
});
