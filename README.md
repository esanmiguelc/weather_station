# README

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


`Result` class is a container for the results of "interactor" classes. This models the success or failure of those interactors and provides us a clean interface for us to use in our controller.

## Additional Considerations

- With additional time I would use more address validation and autocompletion on the UI with something like google maps api.

- For the sake of simplicity, we are currently caching with the default memory store. In order to have a more robust caching implementation it should use a different centralized store such as Redis or MemCache so that it can use the cache across distinct instances of the rails server

- For this example I used plain javascript, depending on the needs I would consider a framework such as React if richer UI experiences is required or other priorities are valued such as faster rendering of the initial page and fetching the information after.
