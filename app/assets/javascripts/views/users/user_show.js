VillageBicycle.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  tagName: 'article',

  events: {
    'click .subview-list-li': 'toggleActiveClass',
    'click #add-bike': 'renderBikeForm',
    'click .edit-page': 'renderEditModal'
  },

  initialize: function () {
    this._activeBikeListItemViews = []
    this.listenTo(this.model, "sync", this.render)
    this.listenTo(this.model.bikes(), "sync remove add", this.render)
  },

  render: function () {
    var templatedShow = this.template({
      user: this.model
    });

    this.$el.html(templatedShow);
    this.attachBikeList();

    return this;
  },

  attachBikeList: function () {
    var bikeList = new VillageBicycle.Views.BikeListView({
      collection: this.model.bikes()
    });

    this.$el.find('#bike-list').append(bikeList.render().$el);
  },

  renderBikeForm: function () {
    var bike = new VillageBicycle.Models.Bike();
    this.model.bikes().add(bike);

    var bikeModal = new VillageBicycle.Views.ModalForm({
      model: bike
    });

    this.$el.append(bikeModal.render().$el)

  },

  renderEditModal: function () {
    var editModal = new VillageBicycle.Views.ModalForm({
      model: this.model
    });

    this.$el.append(editModal.render().$el)
  }

});
