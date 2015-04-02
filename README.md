# Village Bicycle
### A Peer-to-peer bike renting app inspired by Spinlister and AirBnB
[Live Link][link]

[link]: http://village-bicycle.com

## Features

* Create a User profile
* Add your bikes or search for others to rent
* Search for bikes by bike spec (like size or frame-style) or availability
* Create a rental request for someone's bike
* Review requests made or requests received on the User profile page
* Users can approve/reject requests received and also edit requests they've made

## Implementation
Village Bicycle is built on a Ruby on Rails API with a Backbone.js front-end
* Uses Rails authentication with BCrypt
* Allows users to log in/sign up with Twitter via [OmniAuth](https://github.com/intridea/omniauth)
* Generates ActionMailer for new user activation
* Implements bikes search using ActiveRecord to generate custom SQL queries
* Leverages the [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/) to display a map with listings in given area.
* Supports file upload with [paperclip](https://github.com/thoughtbot/paperclip) and stores files in AWS S3 database
* Includes model tests in RSpec with support from [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) gem.
* Incorporates simple search for Users or Bikes with [pg_search](https://github.com/Casecommons/pg_search)

## To Do
Id like to incorporate the following features:
* Users can specify bike maker with Makes table
* Respond to and compose messages to other users
* Give feedback on users and bikes
* Remember favorite bikes for users
