require 'rails_helper'

describe 'Authors API' do
  it "retrieves individual author information" do
    test_author = Author.create(name: "AuthorTest")

    get "/api/v1/authors/#{test_author.id}"
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(result.size).to eq(1)
    expect(result[:data]).to include({
    	:id => a_kind_of(String),
    	:type => "author",
    	:attributes => a_hash_including(
    		:id => a_kind_of(Integer),
    		:name => "AuthorTest",
    		:created_at => a_kind_of(String),
    		:updated_at => a_kind_of(String)
    		)
    	})
  end
end
