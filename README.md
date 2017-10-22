# Approach

This is a Rails 5.1.4 only application, using Ruby 2.4.2.

To display the products and variants (including inventory counts) served by the `json_api`-compliant [pants](https://github.com/apoorva-muralidhara/pants), it uses the [json_api_client](http://github.com/chingor13/json_api_client) gem.

The `Product` and `Variant` classes in `app/models` inherit from a `Base` class that inherits from `JsonApiClient::Resource` and set the API URL to `http://localhost:3535/`.

The model spec for `Product` uses [webmock](https://github.com/bblimke/webmock) to stub a request to and response from the [pants](https://github.com/apoorva-muralidhara/pants) API and verify that `Product.all` fetches the products and associated variants as expected.

# Running

## Installing gems
To install gems, you need to run this at the top level of the Rails app:
```bundle install``

## Postgres
I'm not using a database in this app, but I've configured it to use a Postgres database in case that's needed in the future, so you might want to do this to avoid warnings:

* In the Postgres client:
```
create role clothes with createdb login password 'clothes';
```

* In the Rails app:
```
bundle install
rails db:create:all
RAILS_ENV=test db:migrate
```

## Running specs
To run the specs:
```
rspec -fd
```

## Running the service
Before running clothes, make sure to run the [pants](https://github.com/apoorva-muralidhara/pants) API at port 3535 with `rails s -p 3535`, as explained on its README page.

## Running app in development

To run the app:
```
rails s
```

Note that clothes expects the [pants](https://github.com/apoorva-muralidhara/pants) API to be running and serving products from its endpoint

```
http://localhost:3535/products
```

##Seeing the products
To see the products and their inventory, go to
```
http://localhost:3000/products
```

#Improvements
* Currently the `/products` page blows up with a `JsonApiClient::Errors::ConnectionError` when [pants](https://github.com/apoorva-muralidhara/pants) isn't running.  This needs to be handled with some kind of user-friendly message.
* The service URL, `http://localhost:3535/products`, is hardcoded in `app/models/base.rb`, but should be configurable.  It may be different in different environments, so at the very least it could be set in `config/environments/development.rb` and so on.  Perhaps these URLs could be set through environment variables.
* There should be a test for the Web page showing the products and inventory, perhaps a Cucumber feature or RSpec feature spec.
* If it's certain that this app is not going to need a database, I should remove its configuration to have one.
* If there were other models that had nothing to do with consuming the [pants](https://github.com/apoorva-muralidhara/pants) API, I could namespace the models under a `PantsApi` module, asuggested on the [json_api_client](http://github.com/chingor13/json_api_client) README page.
* The view (`app/views/products/index.html.erb`) could be broken up into partials--for example, a partial to show each variant, and another partial to show each product.
* The view is far from beautiful, and could certainly benefit from some CSS love, for example.
* Some logging around the API calls would be nice.








