VillageBicycle.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  tagName: 'article',

  events: {
    'click .subview-list-li:not(.active)': 'toggleActiveClass',
    'click #add-bike': 'renderBikeForm'
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
    var currentActive = $('.subview-list-li.active')

    if (currentActive && this.activeBikeListItemView) {
      this.activeBikeListItemView.$el.remove();
      this.activeBikeListItemView.remove();
      currentActive.removeClass('active');
    }

    $(event.currentTarget).addClass('active')
                          .one("transitionend", this._addBikeInfo.bind(this));
  },

  renderBikeForm: function () {
    var bike = new VillageBicycle.Models.Bike();
    this.model.bikes().add(bike);

    var bikeModal = new VillageBicycle.Views.BikeForm({
      model: bike
    });

    this.$el.append(bikeModal.render().$el)

  },

  _addBikeInfo: function (event) {
    var bikeId = $(event.currentTarget).data('bike-id');
    var bike = this.model.bikes().get(bikeId);

    this.activeBikeListItemView = new VillageBicycle.Views.BikeListItemView({
      model: bike
    })

    $('.subview-list-li.active .bike-list-item-info')
                            .html(this.activeBikeListItemView.render().$el);
  }

});
