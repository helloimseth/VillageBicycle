VillageBicycle.Views.ListView = Backbone.View.extend({
  bikesTemplate: JST['bikes/bike_list'],

  requestsTemplate: JST['requests/request_list'],

  tagName: 'ul',

  events: {
    'click .subview-list-li': 'toggleActiveClass',
  },

  initialize: function (options) {
    this.subViewClass = options.subViewClass

    this._activeListItemViews = []
    this.listenTo(this.collection, "sync remove add", this.render)
  },

  render: function () {
    var templatedList;

    if (this.collection.url === "/api/requests" ) {
      templatedList = this.requestsTemplate({
        requests: this.collection
      });
    } else {
      templatedList = this.bikesTemplate({
        bikes: this.collection
      });
    }

    this.$el.html(templatedList);

    return this;
  },

  toggleActiveClass: function (event) {
    this._activeListItemViews.forEach(function (view) {
      var id = $(event.currentTarget).data('item-id');

      if (view.model.id == id) { view.remove(); }
    });

    $(event.currentTarget).toggleClass('active')
                          .one("transitionend", this._addItemInfo.bind(this));
  },

  _addItemInfo: function (event) {
    var $infoArticle = $(event.currentTarget).find('.list-item-info');

    if ($(event.currentTarget).hasClass('active')) {
      var id = $(event.currentTarget).data('item-id');
      var item = this.collection.get(id);

      var listItemView = new VillageBicycle.Views.ListItemView({
        model: item
      })

      this._activeListItemViews.push(listItemView)

      $infoArticle.html(listItemView.render().$el);
    }
  },

  remove: function () {
    this._activeListItemViews.forEach(function (view) {
      view.remove();
    });
    Backbone.View.prototype.remove.call(this);
  }
});
