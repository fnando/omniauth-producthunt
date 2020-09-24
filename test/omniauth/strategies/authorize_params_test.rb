# frozen_string_literal: true

require "test_helper"

class AuthorizeParamsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::ProductHunt.new(app, "consumer_id", "consumer_secret")
  end

  test "sets defaults scopes" do
    strategy.stubs(:session).returns({})
    assert_equal "public private", strategy.authorize_params.scope
  end

  test "injects required scopes" do
    strategy = OmniAuth::Strategies::ProductHunt.new(
      nil,
      "ID",
      "SECRET",
      scope: "team"
    )
    strategy.stubs(:session).returns({})

    assert_equal "team public private", strategy.authorize_params.scope
  end

  test "sets unique scopes" do
    strategy = OmniAuth::Strategies::ProductHunt.new(
      nil,
      "ID",
      "SECRET",
      scope: "private"
    )
    strategy.stubs(:session).returns({})

    assert_equal "private public", strategy.authorize_params.scope
  end
end
