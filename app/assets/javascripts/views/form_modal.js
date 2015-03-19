VillageBicycle.Views.FormModal = Backbone.View.extend({
  userTemplate: JST['users/user_form'],

  bikeTemplate: JST['bikes/bike_form'],

  requestTemplate: JST['requests/request_form'],

  tagName: 'figure',

  events: {
    'submit .modal-form form': 'submitForm',
    'click .x-out': "remove",

    'change #bike-picture': "changePicture",

    'click #delete-request': "deleteRequest"
  },

  render: function () {
    var templatedForm;

    if (this.model.urlRoot === '/api/bikes') {
      templatedForm = this.bikeTemplate({
        bike: this.model
      });
    } else if (this.model.urlRoot ==='api/users') {
      templatedForm = this.userTemplate({
        user: this.model
      });
    } else {
      templatedForm = this.requestTemplate({
        request: this.model
      });
    }

    this.$el.html(templatedForm);

    return this;
  },

  submitForm: function (event) {
    event.preventDefault()

    var attrs = $(event.currentTarget).serializeJSON()

    this.model.save(attrs, {
      success: function () {
        this.collection && this.collection.add(this.model)
        this.remove();
      }.bind(this)
    })
  },

  changePicture: function (event) {
    var file = event.currentTarget.files[0];

    var fileReader = new FileReader();

    fileReader.onloadend = function () {
      this.model.set("picture", fileReader.result);
    }.bind(this);

    fileReader.readAsDataURL(file);
  },

  deleteRequest: function (event) {
    event.preventDefault()

    this.model.destroy({
      success: this.remove.bind(this)
    })
  }
})
