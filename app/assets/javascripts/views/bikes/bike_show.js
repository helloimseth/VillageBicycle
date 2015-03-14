VillageBicycle.Views.BikeShow = Backbone.View.extend({

  template: JST['bikes/show'],

  tagName: 'article',

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var templatedShow = this.template({
      bike: this.model
    });

    this.$el.html(templatedShow);

    return this;
  }

});
