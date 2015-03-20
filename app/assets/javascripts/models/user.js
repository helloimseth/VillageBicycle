VillageBicycle.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',

  bikes: function () {
    if (!this._bikes) {
      this._bikes = new VillageBicycle.Collections.Bikes([], {
        owner: this
      });
    }

    return this._bikes;
  },

  pendingRequests: function () {
    if (!this._pendingRequests) {
      this._pendingRequests = new VillageBicycle.Collections.Requests();
      this._pendingRequests.bikeOwner = this;
    }

    return this._pendingRequests;
  },

  approvedRequests: function () {
    if (!this._approvedRequests) {
      this._approvedRequests = new VillageBicycle.Collections.Requests();
      this._pendingRequests.bikeOwner = this;
    }

    return this._approvedRequests;
  },

  requestsMade: function () {
    if (!this._requestsMade) {
      this._requestsMade = new VillageBicycle.Collections.Requests();
    }

    return this._requestsMade;
  },

  confirmedRequests: function () {
    if (!this._confirmedRequests) {
      this._confirmedRequests = new VillageBicycle.Collections.Requests();
    }

    return this._confirmedRequests;
  },

  parse: function (response) {
    if (response.bikes) {
      this.bikes().set(response.bikes);
      delete response.bikes;
    }

    if (response.pending_requests) {
      this.pendingRequests().set(response.pending_requests);
      delete response.pending_requests;
    }

    if (response.approved_requests) {
      this.approvedRequests().set(response.approved_requests);
      delete response.approved_requests;
    }

    if (response.requests_made) {
      this.requestsMade().set(response.requests_made);
      delete response.requests_made;
    }

    if (response.confirmed_requests) {
      this.confirmedRequests().set(response.confirmed_requests);
      delete response.confirmed_requests;
    }

    if (response.neighborhood_id) {
      var hoodName = VillageBicycle.Sets
                                   .grab("neighborhoods",response.neighborhood_id)
                                   .name;
      this.set("neighborhood", hoodName);
      delete response.neighborhood_id;
    }

    return response
  },

  toJSON: function () {
    return {user: _.clone(this.attributes)}
  }
});
