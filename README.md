# The Village Bicycle

[Heroku link][heroku]

[heroku]: http://villagebicycle.herokuapp.com

## Minimum Viable Product
The Village Bicycle is an AirBnB clone for renting or buying bicycles from other people. Users can:

- [x] Create accounts
- [x] Create sessions (log in)
- [x] Create bikes
- [x] View bikes and other users
- [x] Search bikes by location
- [ ] Search bikes by availability
- [x] Search bikes by bikes table columns
- [ ] Make rental requests for bikes
- [ ] Approve requests for bike rentals

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication/Sign-up, Editing/updating profile. (~1 days)
I will implement the user model with Rails based authentication using BCrypt. I
will implement the new user sign-up functionality using an initial form taking email/password which will
bring the new user to a complete new profile form, which will be made with a _form partial
that will also be used for editing. This will also require the creation of a Size model and Neighborhood
Model to populate selection sets. By the end of this phase, users will be able to sign-up
edit, and view their own profiles.

[Details][phase-one]

### Phase 2: Creating/Editing/Showing owned Bikes (~1 day)
I will implement the bike model with a belongs_to association to users. By the end of this phase,
users will be able to create, edit, and view owned bikes. Users' show pages will also list the
bikes they own and that list will be anchored to their respective bike's show page. Users will also be
able to destroy the bikes they own. As with users, I will implement the new bike creation using a _form
partial that will also be used for the edit functionality.

[Details][phase-two]

### Phase 3: Searching Bikes (~1 day)
In this phase, I will implement a search action on the BikesController as well as search form view.
This will require the use of google maps' api to search by location and display the locations on a
map. By the end of this phase, users will be able to search for bikes by location, availability,
for rent/for purchase and/or type and view a list of bikes matching the search terms.

[Details][phase-three]

### Phase 4: Requesting/Approving bike rentals/purchases (~2 days)
I make a Requests model, controller, and form view that will be accessible from the
bike show page. By the end of this phase Users will make a request for a bike, which
will have the reviewed field set to false by default; this will cause a notification email
to the bike owner, as well as a notification on the user's profile page, only visible if the
show page belongs to the current user. Bike owners will have a requests index which will
lead them to a request show page where they can approve, deny or response to a request.
Approval/denial will trigger an email to be sent to the requestor, as well as a notification
to be sent to the user's profile page, also only visible if the show page belongs to the current user.

Approved requests will be listed on the requestor and bike owners homepages, again, only visible if the show page belongs to the current user. Past requests won't be displayed.

The request will show a subtotal and total + tax for the rental costs and input fields for cc info.

[Details][phase-four]

### Phase 5: Basic CSS Layout/Positioning (~1 day)
This phase will involve creating the basic CSS stylesheet for the views focusing on layout and positioning.
I will implement the css reset, cycle through the views adding pertinent classes to the semantic tags when necessary,
and go view by view styling the layout to fit the wireframes. At the end of this phase, the project will
resemble a website that isn't a complete eyesoar.

[Details][phase-five]

### Phase 6: Viewing Users and Bikes in Backbone (~1 day)
This phase translate the users and bikes views (except searches and requests) into Backbone. In this phase, I will
create an API namespace in the routes and provide JSON templates using JBuilder. I will make Models for users
and bikes, with a nested bikes collection under users using a bikes() function and overwriting the user model's
parse function. The users's view will be a composite view to incoroporate both the user info, their owned bikes list
and for the future addition of requests and scheduled rentals information.

[Details][phase-six]

### Phase 7: Searching Bikes in Backbone (~1 day)
This phase will translate the bikes search functionality into Backbone. This will require implementing the google maps api in javascript, as well as Kaminari for paginated views. At the end of this phase, users will be able to search for bikes in Backbone. Results index view will be composite of bike items and the search terms, which can be manipulated and will dynamically update the search results.

[Details][phase-seven]

### Phase 8: Requesting/Approving Bikes in Backbone (~1 day)
This phase will translate the request and approval functionality into Backbone. In this phase, I will create
a request form view and request respond views, the latter of which will be added to the users profile composite view.
Also, the users's profile compositive view will add a notification alarm, based on any unreviewed requests/approvals,
as well as a list of upcoming scheduled rentals.


[Details][phase-eight]

### Bonus Features (TBD)
- [ ] Users can specify bike maker with Makes table
- [ ] Search for ride buddies by preferred riding time
- [ ] Make ride buddy requests to other users via message
- [ ] Respond to and compose messages to other users
- [ ] Give feedback on users and bikes
- [ ] Remember favorite bikes for users
- [ ] Make purchase requests for bikes
- [ ] Approve requests for bike purchases
- [ ] Multiple sessions/session management

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md
[phase-six]: ./docs/phases/phase6.md
[phase-seven]: ./docs/phases/phase7.md
[phase-eight]: ./docs/phases/phase8.md
