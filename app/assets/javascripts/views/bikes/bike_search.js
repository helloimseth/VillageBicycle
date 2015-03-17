VillageBicycle.Views.BikeSearch = Backbone.View.extend({
  template: JST['bikes/search'],

  tagName: 'main',

  render: function () {
    var templatedSearch = this.template();

    this.$el.html(templatedSearch);

    return this;
  }
})
