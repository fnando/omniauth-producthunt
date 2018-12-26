# Omniauth::ProductHunt

[![Travis-CI](https://travis-ci.org/fnando/omniauth-producthunt.svg)](https://travis-ci.org/fnando/omniauth-producthunt)
[![CodeClimate](https://codeclimate.com/github/fnando/omniauth-producthunt.svg)](https://codeclimate.com/github/fnando/omniauth-producthunt)
[![Test Coverage](https://codeclimate.com/github/fnando/omniauth-producthunt/badges/coverage.svg)](https://codeclimate.com/github/fnando/omniauth-producthunt/coverage)
[![Gem](https://img.shields.io/gem/v/omniauth-producthunt.svg)](https://rubygems.org/gems/omniauth-producthunt)
[![Gem](https://img.shields.io/gem/dt/omniauth-producthunt.svg)](https://rubygems.org/gems/omniauth-producthunt)

[ProductHunt](http://producthunt.com)'s OAuth Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-producthunt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-producthunt

## Usage

`OmniAuth::Strategies::ProductHunt` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: <https://github.com/intridea/omniauth>.

First, create a new application at <https://api.producthunt.com/v1/oauth/applications>. Your callback URL must be something like `https://example.com/auth/producthunt/callback`. ProductHunt requires https even for development, so make sure you set up something that can support it.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`. This example assumes you're exporting your credentials as environment variables.

Notice that omniauth-producthunt will always inject `public` and `private` scopes, so it can retrieve the required information.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :producthunt,
            ENV["PRODUCTHUNT_CLIENT_ID"],
            ENV["PRODUCTHUNT_CLIENT_SECRET"]
end
```

Now visit `/auth/producthunt` to start authentication against ProductHunt.

## Contributing

1. Fork [omniauth-producthunt](https://github.com/fnando/omniauth-producthunt/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
