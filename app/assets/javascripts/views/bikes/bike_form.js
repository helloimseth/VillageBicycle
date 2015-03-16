VillageBicycle.Views.BikeForm = Backbone.View.extend({
  template: JST['bikes/bike_form'],

  tagName: 'figure',

  events: {
    'submit .modal-form form': 'updateBike',
    'change #bike-picture': "changePicture"
  },

  render: function () {
    var templatedForm = this.template({
      bike: this.model
    });

    this.$el.html(templatedForm);

    return this;
  },

  updateBike: function (event) {
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
