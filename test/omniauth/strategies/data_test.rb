# frozen_string_literal: true

require "test_helper"

class DataTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::ProductHunt.new(app, "consumer_id", "consumer_secret")
  end

  let(:payload) do
    JSON.parse(File.read("./test/me.json"))
  end

  setup do
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/v1/me").returns(response)
    strategy.stubs(:access_token).returns(access_token)
  end

  test "returns info" do
    info = strategy.info

    assert_equal "Nando Vieira", info[:name]
    assert_equal "fnando", info[:nickname]
    assert_equal "email@example.com", info[:email]
    assert_equal "Web Developer", info[:description]
    assert_equal "http://nandovieira.com", info.dig(:urls, :site)
    assert_equal "https://www.producthunt.com/@fnando",
                 info.dig(:urls, :profile)
    assert_equal "https://ph-avatars.imgix.net/40304/original?auto=format&fit=crop&crop=faces&w=100&h=100", info[:image] # rubocop:disable Layout/LineLength
  end

  test "returns uid" do
    assert_equal 40_304, strategy.uid
  end
end
