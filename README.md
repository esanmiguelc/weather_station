# README

Example app demonstrating how to call the WeatherAPI service using a rails application.

## Setup

```
$ bin/setup
```

## To run the application

```
$ bin/dev
```

## To run the tests

```
$ bundle exec rspec
```

## Deconstructing

`FetchForecast` is an "interactor" class which orchestrates all the work to be done  (validating, cleaning data, fetching the forecast... etc) in order to fetch the current forecast for a given zip.

`WeatherService` makes the actual network call to the weather API. By putting the network call behind this class we can swap the api we use and as long as we abide by the existing contract in what we return, the rest of the code is none the wiser. This service also caches the request for 30 minutes given a specific zip. In a production environment, I might also add things like a circuit-breaker pattern or retries to improve the resiliency of the service.

`AddressValidator` is encapsulated to reduce duplication and extending it's behavior in the future. We might want to improve the logic or even make a network call to validate against an address validation service. In this case, like the `WeatherService` none of our other code needs to know that anything has changed.

`Result` class is a container for the results of the classes above. This wraps our success or failure of those classes and provides us a clean way to fork logic based on those results.

## Additional Considerations

- With additional time I would use more address validation and autocompletion on the UI with something like google maps api.

- For the sake of simplicity, we are currently caching with the default memory store. In order to have a more robust caching implementation it should use a different centralized store such as Redis or MemCache so that it can use the cache across distinct instances of the rails server. In order to see the caching in action, look up a location and refresh the page with the temperature, that will add a "Cached" label to the widget.

- For this example I didn't need additional javacript, depending on the needs I would consider using the built in options for Rails for light usage or a framework such as React if richer UI experiences is required or other priorities are valued such as faster rendering of the initial page load and fetching the information later.

- The api key is in the checked in `.env` file for the sake of easier setup and testing. However, a real production key should exist in a safe space and assigned to the environment as part of a CI/CD step.

- For the errors we used symbols to match translation keys so that we can display the appropriate message to the user. This is specially helpful if internationalization is desired in the future as it makes adding other languages trivial.
