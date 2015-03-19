VillageBicycle.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  tagName: 'article',

  events: {
    'click #add-bike': 'renderBikeForm',
    'click .edit-page': 'renderEditModal'
  },

  initialize: function () {
    this._subViews = []
    this.listenTo(this.model, "sync", this.render)
    this.listenTo(this.model.bikes(), "sync remove add", this.render)
    this.listenTo(this.model.pendingRequests(), "remove add", this.render)
  },

  render: function () {
    var templatedShow = this.template({
      user: this.model
    });

    this.$el.html(templatedShow);
    this.attachListView({
      selector: '#bike-list',
      collection: this.model.bikes(),
    });

    if (this.model.id === VillageBicycle.currentUserId) {
      this.attachRequestViews();
    }

    return this;
  },

  renderBikeForm: function () {
    var bike = new VillageBicycle.Models.Bike();

    var bikeModal = new VillageBicycle.Views.FormModal({
      model: bike,
      collection: this.model.bikes()
    });

    this.$el.append(bikeModal.render().$el)
  },

  renderEditModal: function () {
    var editModal = new VillageBicycle.Views.FormModal({
      model: this.model
    });

    this.$el.append(editModal.render().$el)
  },

  attachRequestViews: function () {
    this.attachListView({
      selector: '#pending-requests-list',
      collection: this.model.pendingRequests()
    });

    this.attachListView({
      selector: '#approved-requests-list',
      collection: this.model.approvedRequests(),
    });

    this.attachListView({
      selector: '#requests-made-list',
      collection: this.model.requestsMade(),
    });

    this.attachListView({
      selector: '#confirmed-requests-list',
      collection: this.model.confirmedRequests(),
    });
  },

  attachListView: function (options) {
    var listView = new VillageBicycle.Views.ListView({
      collection: options.collection
    });

    this._subViews.push(listView);

    this.$el.find(options.selector).append(listView.render().$el);
  }

});
