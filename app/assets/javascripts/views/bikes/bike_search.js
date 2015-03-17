VillageBicycle.Views.BikeSearch = Backbone.View.extend({
  template: JST['bikes/search'],

  tagName: 'main',

  events: {
    "submit .search-form": "performSearch"
  },

  render: function () {
    var templatedSearch = this.template();

    this.$el.html(templatedSearch);

    return this;
  },

  performSearch: function (event) {
    event.preventDefault()
    var params = $(event.currentTarget).serializeJSON();

    var searchResults = new VillageBicycle.Collections.Bikes();
    this.collection.url += "/search?" + $.param(params)

    this.collection.fetch({
      success: function () {
        console.log(this.collection);
      }.bind(this)
    })
  }
})
