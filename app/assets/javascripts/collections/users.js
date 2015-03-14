VillageBicycle.Collections.Users = Backbone.Collection.extend({

  url: '/api/users',

  model: VillageBicycle.Models.User,

  getOrFetch: function (id) {
    var user = this.find(id)

    if (!user) {
      user = new VillageBicycle.Models.User({
        id: id
      });

      this.add(user);
    }

    user.fetch();

    return user;
  }

});

VillageBicycle.Collections.users = new VillageBicycle.Collections.Users()
