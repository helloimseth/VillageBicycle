VillageBicycle.Views.RequestFormModal = Backbone.View.extend({
  template: JST['requests/form_modal'],

  tagname: 'section',

  render: function () {
    var formModal = this.template({
      request: this.model
    });

    this.$el.html(formModal);

    return this;
  }
});
