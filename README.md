# Flutter Weather

#### Flutter Weather is a weather application that lets you retrieve the current weather at your location, as well as predictions for the day. You can also retrieve the weather for a specific city, with weather predictions for the next few days. You can obtain details such as hour-by-hour temperatures. ☀️

## Architecture 🏢

I made the choice to try - with my knowledge - to respect as much as possible the conventions of clean architecture. I have also set up various contracts and implementations to respect SOLID principles, in particular the "Interface Segregation Principle" and the "Dependency Inversion Principle". 

Some things may please or shock you, but like many philosophies they are open to interpretation. I'm open to suggestions and advice, but I don't consider my work to be perfect.

## Dependencies 🔗

I chose to use certain libraries to make the application more user-friendly and the architecture more efficient. Here are the libraries I was asked to use:

flex_color_scheme: ^7.1.2
get_it: ^7.6.0
auto_route: ^7.4.0
 provider: ^6.0.5

***Here are the ones I chose to use:***

**geolocator: ^9.0.2** (Geolocation services, the library I'm used to using, which is powerful and regularly updated)

**http: ^1.0.0** (I could have used DIO, but it wasn't the right solution for the job, and I'm used to working with http. Requests are not complex, so this library was sufficient. You don't need a bulldozer to plant a flower.)

**pull_to_refresh: ^2.0.0** (As its name suggests, this library enables you to update the interface with a user drag action. It's not essential, but it makes for a more intuitive and pleasant user experience.)

**percent_indicator: ^4.2.3** (This library allows me to display temperatures hour by hour for one day. With a daily maximum temperature, this library intuitively displays to the user at what time the maximum temperatures will be reached.)

**mockito: ^5.4.1** (As I had to carry out tests, I chose to use this library to mock API responses, since tests must be independent of the database.)

**test: 1.24.1** ( logic c: )

## Tests 🌋

In the tests folder, you'll find various tests: unit tests and integration tests. If you've never tested a widget, you'll have a hard time finding them - even if you look hard enough.
I've mocked the API responses using the Mockito library and JSON.
This application isn't intended to be deployed in production, so I didn't think it necessary to write all the integration tests, since they're tedious and very repetitive. 
I figured that the integration tests I wrote would serve as proof of my ability to write integration tests. If you'd like to see a complete set of tests, please visit [HERE](https://github.com/ClementG63/Neo4Driver).

You'll also find unit tests in this repository, used to test the various tools I've developed to meet my needs (utils).
