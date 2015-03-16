VillageBicycle.Views.DeleteModal = Backbone.View.extend({
  template: JST['delete_modal'],

  tagName: 'section',

  events: {
    "click #yes-button": "deleteModel",
    "click #no-button": "removeModal"
  },

  render: function () {
    var deleteModal = this.template();

    this.$el.html(deleteModal);

    return this;
  },

  deleteModel: function (event) {
    event.preventDefault();

    this.model.destroy();

    Backbone.history.navigate("users/" + this.model.get('owner_id'), {
      trigger: true
    })
  },

  removeModal: function (event) {
    event.preventDefault();

    this.remove();
  }
});
