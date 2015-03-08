# Schema Information

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique
first_name		| string	| not null
last_name		| string	| not null
neighborhood_id | integer	| not null, foreign key (references neighborhoods)
street_num		| integer	| 
street_name		| string	| 
size_id 		| integer	| not null, foreign key (references sizes)
img_url			| string	|
ride_partner	| boolean	| not null 

## bikes
column name 	| data type | details
----------------|-----------|-----------------------
id          	| integer   | not null, primary key
owner_id    	| integer   | not null, foreign key (references users)
condition   	| string    | not null
make_id			| integer	| not null, foreign key (references makes) *(bonus)*
year			| integer	|
category		| string	| not null
gender			| string	| not null
size_id 		| integer	| not null, foreign key (references sizes)
num_gears		| integer	| not null
img_url			| string	| 
for_sale		| boolean	| not null, *(bonus)*
for_rent		| boolean	| not null
sale_price		| integer	|
hour_rent_price	| integer	|
day_rent_price	| integer	|
week_rent_price	| integer	|
notes			| text		|


## add_ons
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
bike_id	  	| integer	| not null, references bikes
extra_id    | integer   | not null, references extras


## extras
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
name	  	| string	| not null
icon_url    | string    | not null


## sizes
column name 		| data type | details
--------------------|-----------|-----------------------
id          		| integer   | not null, primary key
frame_size  		| integer   | not null
suggested_height    | string    | not null
suggested_leg_length| string	| not null


## requests
column name 		| data type | details
--------------------|-----------|-----------------------
id          		| integer   | not null, primary key
request_type  		| string	| not null
requestor_id	    | integer   | not null, references users
bike_id				| integer	| not null, references bikes
start_date			| date		| not null
start_time			| time		| not null
end_date			| date		| not null
end_time			| time		| not null
reviewed			| boolean	| not null
notified_of_response| boolean	| not null
approved			| boolean	|

## neighborhoods
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
name       	| string    | not null


## Bonus 

## makes
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
name	  	| string	| not null
country     | string    |


## feedback (polymorphic)
column name 		| data type | details
--------------------|-----------|-----------------------
id          		| integer   | not null, primary key
reviewable_id		| integer   | not null, foreign key 
reviewable_type		| string	| not null 
reviewer_id		    | integer   | references users
rating				| integer	| not null
feedback_body		| text		|

###( below only necessary if ride-buddy functionality exists, otherwise, bike availability can be calculated by times that are not currently unavailable )

## availabilities (polymorphic)
column name 		| data type | details
--------------------|-----------|-----------------------
id          		| integer   | not null, primary key
available_id		| integer   | not null, foreign key 
available_type		| string	| not null 
time_slot_id	    | integer   | not null, references time_slots
day of week			| string	| not null

## time_slots
column name 		| data type | details
--------------------|-----------|-----------------------
id          		| integer   | not null, primary key
name				| string    | not null
hour_range_start	| integer	| not null 
hour_range_end	    | integer   | not null
am					| boolean	| not null


