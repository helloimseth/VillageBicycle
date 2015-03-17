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

    return this;
  },

  toggleActiveClass: function (event) {

    this._activeBikeListItemViews.forEach(function (view) {
      var bikeId = $(event.currentTarget).data('bike-id');
      if (view.model.id == bikeId) {
        view.remove();
      }
    });

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
    var $infoArticle = $(event.currentTarget).find('.bike-list-item-info');

    if ($(event.currentTarget).hasClass('active')) {
      var bikeId = $(event.currentTarget).data('bike-id');
      var bike = this.model.bikes().get(bikeId);

      var bikeListItemView = new VillageBicycle.Views.BikeListItemView({
        model: bike
      })

      this._activeBikeListItemViews.push(bikeListItemView)

      $infoArticle.html(bikeListItemView.render().$el);
    }  
  }

});
