# Match best restaurants

This is an app made for getting arguments from a user and searching for the top 5 best restaurants that fit the description given. It is now only backend, so it doesn't have an UI. To run the project, simply open the rails console and refer to [running search page](https://github.com/Joranhezon/match-restaurants/blob/main/RUNNINGSEARCH.md). To learn more about the decisions behind the implementation of this project, please refer to [decisions page](https://github.com/Joranhezon/match-restaurants/blob/main/DECISIONS.md)

## Installation

This project was made using Ruby version ```2.6.4``` and the framework [Ruby on Rails](https://rubyonrails.org/) version ```6.1.4```. As such, you will need them both installed to use it. Please refer to [here](https://www.ruby-lang.org/en/downloads/) to install ruby and run the following command to install rails:

```gem install rails```

To check each installation, run the following commands:
```ruby -v```
```rails -v```

After completing installation of both dependencies, run the following command:

```bundle install```

And now you're ready to use the app!

## Running Tests

This project was made using TDD and [Rspec](https://rspec.info/). All tests are located in the ```spec``` folder in the root of the project. To run the tests made, use the following commands

### Every test
```rspec```

### A specific file or folder
```rspec <path-to-file>```

## Code Style

To follow the [guidelines](https://rubystyle.guide/) created by the ruby community about writing ruby code, this project is using [rubocop](https://github.com/rubocop/rubocop). We recommend running and fixing any issue pointed out before making any commit. To run it, use the following command:

```rubocop```
