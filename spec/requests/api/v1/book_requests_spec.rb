require 'rails_helper'

describe 'Books API' do
  it "retrieves book information" do
      get "/api/v1/books"
      results = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
  end
end
