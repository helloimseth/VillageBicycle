VillageBicycle.Views.SearchResults = Backbone.View.extend({
  template: JST['search/search_results'],

  tagName: 'section',

  initialize: function () {
    this._subviews = []
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function () {
    var templatedResults = this.template();

    this.$el.html(templatedResults);
    this.attachBikeList();
    this.attachMapView();

    return this;
  },

  attachBikeList: function () {
    var bikeList = new VillageBicycle.Views.ListView({
      collection: this.collection
    });

    this._subviews.push(bikeList);

    this.$el.find('#search-results').append(bikeList.render().$el);
  },

  attachMapView: function (results) {
    var mapView = new VillageBicycle.Views.MapView({
      el: document.getElementById('map-view'),
      collection: this.collection
    })

    this._subviews.push(mapView);

    mapView.renderResultsMap()
  },

  remove: function () {
    this._subviews.forEach(function (view) {
      view.remove()
    });

    Backbone.View.prototype.remove.call(this);
  }
});
