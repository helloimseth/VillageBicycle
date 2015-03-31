VillageBicycle.Models.Request = Backbone.Model.extend({
  urlRoot: "api/requests",

  parse: function (response) {
    if (response.start) {
      console.log(response.start);
      this.set('start', new Date(response.start));
      delete response.start;
    }

    if (response.end) {
      this.set('end', new Date(response.end));
      delete response.end;
    }

    return response;
  },

  formattedTimeString: function (startOrEnd) {
    var dateObj = this.get(startOrEnd);

    var hours = dateObj.getHours();
    var ampm = "AM";

    if (hours - 12 > 12) {
      hours -= 12;
      ampm = "PM";
    } else if (hours === 0) {
      hours = 12;
    }

    var min = dateObj.getMinutes().toString();
    if (min.length === 1) { min = "0" + min; }

    return hours + ":" + min + " " + ampm;
  }
});
