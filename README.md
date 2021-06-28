# Match best restaurants

This is an app made for getting arguments from a user and searching for the top 5 best restaurants that fit the description given. It is now only backend, so it doesn't have an UI. To learn more about the decisions behind the implementation of this project, please refer to [decisions page](https://github.com/Joranhezon/match-restaurants/blob/main/DECISIONS.md)

## Installation

This project was made using Ruby version ```2.6.4``` and the framework [Ruby on Rails](https://rubyonrails.org/) version ```6.1.4```. As such, you will need them both installed to use it. Please refer to [here](https://www.ruby-lang.org/en/downloads/) to install ruby and run the following command to install rails:

```gem install rails```

To check each installation, run the following commands:
```ruby -v```
```rails -v```

After completing installation of both dependencies, run the following command:

```bundle install```

And now you're ready to use the app!

## How to run

To run the project, make sure that rails is installed, then run the following command to open the rails console:

```rails c```

To search for restaurants use the following command:

```GetRestaurantTemplateService.new.call(name: <name>, customer_rating: <customer_rating, distance: <distance>, price: <price>, cuisine: <cuisine>)```

For some use cases, refer to [here](https://github.com/Joranhezon/match-restaurants/blob/main/RUNNINGSEARCH.md). Also, if you want to change the data in ```cuinies.scv``` and ```restaurants.csv```, they are locate in the ```docs``` folder.


## Running Tests

This project was made using TDD and [Rspec](https://rspec.info/). All tests are located in the ```spec``` folder in the root of the project. To run the tests made, use the following commands

### Every test
```rspec```

### A specific file or folder
```rspec <path-to-file>```

## Code Style

To follow the [guidelines](https://rubystyle.guide/) created by the ruby community about writing ruby code, this project is using [rubocop](https://github.com/rubocop/rubocop). We recommend running and fixing any issue pointed out before making any commit. To run it, use the following command:

```rubocop```
