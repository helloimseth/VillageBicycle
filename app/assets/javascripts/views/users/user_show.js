VillageBicycle.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  tagName: 'article',

  events: {
    'click .subview-list-li': 'toggleActiveClass'
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
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

    currentActive && currentActive.removeClass('active');

    $(event.currentTarget).addClass('active');
  }

});
