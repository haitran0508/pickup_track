# PickUp Tracking

App allow users to keep track with the pick-up orders. It gives ETA and the nearest route.

## Packages:

get: ^4.6.5
amplify_flutter: ^0.6.9
amplify_auth_cognito: ^0.6.9
flutter_map: ^3.0.0
latlong2: ^0.8.1
geolocator: ^9.0.2
geojson: ^1.0.0

## Structure:
Screens:
 - Handle UI and 'reacts' to whenever data of [Controller] changes
 
 Controllers:
 - Handle logic and emit data to UI for the display.
 - Controller using [Service] to get data and process them into needed stata.

Services:
 - Work with data source: local, network, files...
 - Used by [Controller] to fetch data.


## Sign in:
Powered by AWS Congito
Sign in by email.
Existing Account: haitran0508+1@gmail.com - pass: haitran1
Have option to allow user to sign up for a new account.

## Sign up:
Powered by AWS Congito
Sign up by email.
After submitting email and password for signing up, the verify code need to be confirmed. The code retrieved by email submitted.

## Tracking
Powered by Flutter_Map, MapBox, GeoJson
Ask user to allow device to use location service to detect current position.
Show route from current position to customer position.

<img src="https://user-images.githubusercontent.com/93150875/198890860-ddac47c8-6d27-41c0-885a-ce0fd75d2548.png" width=25% height=25%>  <img src="https://user-images.githubusercontent.com/93150875/198891047-f99b76ef-a2ef-4e52-bbf8-b575d0ec8aa1.png" width=25% height=25%>  <img src="https://user-images.githubusercontent.com/93150875/198891110-f2318af3-846b-4e25-9b7a-3bd0b5875dfc.png" width=25% height=25%>
<img src="https://user-images.githubusercontent.com/93150875/198891189-c9f65a5d-72b7-4c9e-a616-8f7cade8255a.png" width=25% height=25%>  <img src="https://user-images.githubusercontent.com/93150875/198891234-dfa3e8ec-0bd1-4eba-95b1-2dba04200bb4.png" width=25% height=25%>


