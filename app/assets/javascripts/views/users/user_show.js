VillageBicycle.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  tagName: 'article',

  events: {
    'click .subview-list-li': 'toggleActiveClass',
    'click #add-bike': 'renderBikeForm',
    'click .edit-page': 'renderEditModal'
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
    this.listenTo(this.model.bikes(), "sync remove add", this.render)
  },

  render: function () {
    var templatedShow = this.template({
      user: this.model
    });

    this.$el.html(templatedShow);

    return this;
  },

  toggleActiveClass: function (event) {
    if (this._activeBikeListItemView) {
      this._activeBikeListItemView.$el.remove();
      this._activeBikeListItemView.remove();
    }

    $(event.currentTarget).toggleClass('active')
                          .one("transitionend", this._addBikeInfo.bind(this));
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
  },

  _addBikeInfo: function (event) {
    var bikeId = $(event.currentTarget).data('bike-id');
    var bike = this.model.bikes().get(bikeId);

    this._activeBikeListItemView = new VillageBicycle.Views.BikeListItemView({
      model: bike
    })

    $('.subview-list-li.active .bike-list-item-info')
                            .html(this._activeBikeListItemView.render().$el);
  }

});
