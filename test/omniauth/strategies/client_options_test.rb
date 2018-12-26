require "test_helper"

class ClientOptionsTest < Minitest::Test
  let(:app) { -> env { [200, {}, []] } }

  let(:strategy) do
    OmniAuth::Strategies::ProductHunt.new(app, "consumer_id", "consumer_secret")
  end

  test "sets name" do
    assert_equal "producthunt", strategy.options.name
  end

  test "sets site" do
    assert_equal "https://api.producthunt.com", strategy.options.client_options.site
  end

  test "sets authorize url" do
    assert_equal "/v1/oauth/authorize", strategy.options.client_options.authorize_url
  end

  test "sets token url" do
    assert_equal "/v1/oauth/token", strategy.options.client_options.token_url
  end

  test "sets callback" do
    strategy.expects(:full_host).returns("https://example.com")
    strategy.expects(:script_name).returns("")

    assert_equal "https://example.com/auth/producthunt/callback", strategy.callback_url
  end

  test "sets callback url via options" do
    strategy = OmniAuth::Strategies::ProductHunt.new(app, "consumer_id", "consumer_secret", redirect_uri: "REDIRECT_URI")
    assert_equal "REDIRECT_URI", strategy.callback_url
  end
end