VillageBicycle.Views.BikeListView = Backbone.View.extend({
  template: JST['bikes/bike_list'],

  tagName: 'ul',

  events: {
    'click .subview-list-li': 'toggleActiveClass',
  },

  initialize: function () {
    this._activeBikeListItemViews = []
    this.listenTo(this.collection, "sync remove add", this.render)
  },

  render: function () {
    var templatedList = this.template({
      bikes: this.collection
    });

    this.$el.html(templatedList);

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

  _addBikeInfo: function (event) {
    var $infoArticle = $(event.currentTarget).find('.bike-list-item-info');

    if ($(event.currentTarget).hasClass('active')) {
      var bikeId = $(event.currentTarget).data('bike-id');
      var bike = this.collection.get(bikeId);

      var bikeListItemView = new VillageBicycle.Views.BikeListItemView({
        model: bike
      })

      this._activeBikeListItemViews.push(bikeListItemView)

      $infoArticle.html(bikeListItemView.render().$el);
    }
  },

  remove: function () {
    this._activeBikeListItemViews.forEach(function (view) {
      view.remove();
    });
    Backbone.View.prototype.remove.call(this);
  }
});
