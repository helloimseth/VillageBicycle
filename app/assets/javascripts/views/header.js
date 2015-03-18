VillageBicycle.Views.Header = Backbone.View.extend({
  template: JST['header'],

  tagName: 'nav',

  className: 'header group',

  render: function () {
    var templatedHeader = this.template();

    this.$el.html(templatedHeader);

    return this;
  }
})
