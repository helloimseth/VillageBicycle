VillageBicycle.Views.BikeSearch = Backbone.View.extend({
  template: JST['search/search'],

  tagName: 'main',

  events: {
    "submit .search-form": "performSearch",
    "click .reset": "resetForm"
  },

  render: function () {
    var templatedSearch = this.template();

    this.$el.html(templatedSearch);

    $( "#request-start-date" ).datepicker({
      defaultDate: "today",
      nextText: '⥤',
      prevText: '⥢',
      dateFormat: "yy-mm-dd",
      numberOfMonths: 1
    });

    $( "#request-end-date" ).datepicker({
      defaultDate: "+1d",
      nextText: '⥤',
      prevText: '⥢',
      dateFormat: "yy-mm-dd",
      numberOfMonths: 1
    });

    return this;
  },

  performSearch: function (event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();

    var searchResults = new VillageBicycle.Collections.Bikes();

    searchResults.url += "/search?" + $.param(params);

    searchResults.fetch({
      success: this.renderSearchResults.bind(this, searchResults)
    });
  },

  renderSearchResults: function (results) {
    this.searchResults && this.searchResults.remove();
    this.searchResults = new VillageBicycle.Views.SearchResults({
      collection: results
    });

    this.$el.find('#search-results-container')
            .html(this.searchResults.render().$el)
            .addClass('filled');
  },

  resetForm: function () {
    event.preventDefault();
    var form = $(event.currentTarget).find('form');

    form.find('input, select, textarea')
        .val("")
        .attr("checked", false);
  },

  remove: function () {
    this.searchResults && this.searchResults.remove();
    Backbone.View.prototype.remove.call(this);
  }


})
