# frozen_string_literal: true

require "test_helper"

describe Solaredge::HttpClient do
  before do
    @fake_api_key = "kz1a6ZKJ31T4jwF9prTjt5OVDYhmHl"
  end

  it "performs a request to the expected endpoint" do
    stub_request(:get, "https://monitoringapi.solaredge.com/sites/list.json?api_key=#{@fake_api_key}")
      .and_return(status: 200, body: {}.to_json)

    with_solaredge_config do |c|
      c.api_key = @fake_api_key

      assert Solaredge.client.request("sites/list")
    end
  end

  it "adds additional parameters to the request" do
    stub_request(:get, "https://monitoringapi.solaredge.com/sites/list.json?size=10&api_key=#{@fake_api_key}")
      .and_return(status: 200, body: {}.to_json)

    with_solaredge_config do |c|
      c.api_key = @fake_api_key

      assert Solaredge.client.request("sites/list", params: { size: 10 })
    end
  end

  it "raises Solaredge::MissingApiKey when the API key is not configured" do
    with_solaredge_config do |c|
      c.api_key = ""

      assert_raises Solaredge::MissingApiKey do
        Solaredge.client.request("sites/list")
      end
    end
  end

  it "raises Solaredge::HttpClientError when the API returns a not OK status" do
    stub_request(:get, "https://monitoringapi.solaredge.com/sites/list.json?size=10&api_key=#{@fake_api_key}")
      .and_return(status: 429, body: { String: "too many requests" }.to_json)

    with_solaredge_config do |c|
      c.api_key = @fake_api_key

      assert Solaredge::HttpClientError do
        Solaredge.client.request("sites/list")
      end
    end
  end
end
