VillageBicycle.Views.BikeForm = Backbone.View.extend({
  template: JST['bikes/bike_form'],

  tagName: 'form',

  render: function () {
    var templatedForm = this.template({
      bike: this.model
    });

    this.$el.html(templatedForm);

    return this;
  }
})
