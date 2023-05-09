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

## Deconstructing

`FetchForecast` is an "interactor" class which orchestrates all the work to be done  (validating, cleaning data, fetching the forecast... etc) in order to fetch the current forecast for a given zip.

`WeatherService` makes the actual network call to the weather API. By putting the network call behind this class we can make changes to the api we use and as long as we abide by the existing contract in what we return the rest of the code is none the wiser. This service also caches the request for 30 minutes given a specific zip.

`AddressValidator` is encapsulated to reduce duplication and extending it's behavior in the future. We might want to improve the logic or even make a network call to validate against an address validation service. In this case, like the `WeatherService` none of our other code needs to know that anything has changed.

`Result` class is a container for the results of "interactor" classes. This models the success or failure of those interactors and provides us a clean interface for us to use in our controller.

## Additional Considerations

- With additional time I would use more address validation and autocompletion on the UI with something like google maps api.

- For the sake of simplicity, we are currently caching with the default memory store. In order to have a more robust caching implementation it should use a different centralized store such as Redis or MemCache so that it can use the cache across distinct instances of the rails server. In order to see the caching look up a location and refresh the page with the temperature, that will add a "Cached" label to the widget.

- For this example I used plain javascript, depending on the needs I would consider a framework such as React if richer UI experiences is required or other priorities are valued such as faster rendering of the initial page and fetching the information after.

- The api key is in the checked in `.env` file for the sake of easier setup and testing. However, a real production key should exist in a safe space and assigned to the environment as part of a CI/CD step.

- For the errors we used symbols to match translation keys so that we can display the appropriate message to the user. This is specially helpful if internationalization is desired in the future as it makes adding other languages trivial.
