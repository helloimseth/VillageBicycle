VillageBicycle.Views.SearchResults = Backbone.View.extend({
  template: JST['search/search_results'],

  tagName: 'section',

  events: {
    "click .next-button": "renderNextResults",
    "click .prev-button": "renderPrevResults",

  },

  initialize: function () {
    this._subviews = [];
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var templatedResults = this.template({
      collection: this.collection
    });

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
    });

    this._subviews.push(mapView);

    mapView.renderResultsMap();
  },

  renderNextResults: function (event) {
    event.preventDefault();

    if(!this.page) { this.page = 1; }

    if (this.collection.length === 10) {
      this.page++;
      this.collection.fetch({
        data: { page: this.page }
      });
    }

  },

  renderPrevResults: function (event) {
    event.preventDefault();

    if(this.page && this.page > 1) {
      this.page--;
      this.collection.fetch({
        data: { page: this.page }
      });
    }
  },

  remove: function () {
    this._subviews.forEach(function (view) {
      view.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }
});
