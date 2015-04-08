 VillageBicycle.Views.Header = Backbone.View.extend({
  template: JST['header'],

  tagName: 'nav',

  className: 'header group',

  events: {
    "keyup #pg-search": "performQuickSearch",
    "click .quick-search-result-li": "navigateToResult"
  },

  render: function () {
    var templatedHeader = this.template();

    this.$el.html(templatedHeader);

    return this;
  },

  performQuickSearch: function (event) {
    var query = $(event.currentTarget).val();

    if (event.keyCode == 27) {
      this._searchResults && this._searchResults.remove();
      $(event.currentTarget).val("");
    } else if (query.length > 2) {
      var results = new VillageBicycle.Collections.QuickSearchResults();
      results.url += query;

      results.fetch({
        success: this.renderQuickSearchResults.bind(this, results)
      });
    } else {
      this._searchResults && this._searchResults.remove();
    }
  },

  renderQuickSearchResults: function (results) {
    this._searchResults && this._searchResults.remove();

    this._searchResults = new VillageBicycle.Views.QuickSearchView({
      collection: results
    });

    this.$el.find('#pg-search').after(this._searchResults.render().$el);
  },

  navigateToResult: function (event) {
    var url = $(event.currentTarget).data("url");

    this.$el.find('#pg-search').val("");

    this._searchResults.remove();

    Backbone.history.navigate(url, {
      trigger: true
    });
  }
});
