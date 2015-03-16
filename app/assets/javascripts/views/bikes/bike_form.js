VillageBicycle.Views.ModalForm = Backbone.View.extend({
  userTemplate: JST['users/user_form'],

  bikeTemplate: JST['bikes/bike_form'],

  tagName: 'figure',

  events: {
    'submit .modal-form form': 'submitForm',
    'change #bike-picture': "changePicture"
  },

  render: function () {
    var templatedForm;

    if (this.model.urlRoot === 'api/bikes') {
      templatedForm = this.bikeTemplate({
        bike: this.model
      });
    } else {
      templatedForm = this.userTemplate({
        user: this.model
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
  }
})
