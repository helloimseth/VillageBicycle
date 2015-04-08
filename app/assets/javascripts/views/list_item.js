VillageBicycle.Views.ListItemView = Backbone.View.extend({
  bikeTemplate: JST['bikes/bike_list_item'],

  requestTemplate: JST['requests/request_list_item'],

  tagName: 'article',

  events: {
    "click a": "navigate",
    "click #approve-button": "approveRequest",
    "click #reject-button": "rejectRequest",
    "click #edit-request": "renderEditRequestModal"
  },

  initialize: function () {
    this._fetchIfRequest();
    this.listenTo(this.model, "sync", this.render);
  },

  render: function (event) {
    var templatedListItem;

    if (this.model.urlRoot === "api/bikes") {
      templatedListItem = this.bikeTemplate({
        bike: this.model
      });
    } else {
      templatedListItem = this.requestTemplate({
        request: this.model
      });
    }

    this.$el.html(templatedListItem);

    return this;
  },

  approveRequest: function (event) {
    event.stopPropagation();

    var bikeOwner = this.model.collection.bikeOwner;

    this.model.collection.remove(this.model);
    bikeOwner.approvedRequests().add(this.model);

    this.model.set('approved', true);
    this.model.save();
  },

  rejectRequest: function (event) {
    event.stopPropagation();

    this.model.collection.remove(this.model);

    this.model.set('approved', false);
    this.model.save();
  },

  renderEditRequestModal: function (event) {
    event.stopPropagation();

    var modal = new VillageBicycle.Views.FormModal({
      model: this.model,
      className: 'edit-request'
    });

    $('body').append(modal.render().$el);
  },

  _fetchIfRequest: function() {
    if (this.model.urlRoot === "api/requests") { this.model.fetch({
      success: this.render.bind(this)
    }); }
  },

  navigate: function () {
    // event.preventDefault();
    event.stopPropagation();

    Backbone.history.navigate($(event.currentTarget).attr('href'), {
      trigger: true
    });
  }
});
