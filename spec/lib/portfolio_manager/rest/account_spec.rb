require 'spec_helper'

describe PortfolioManager::REST::Account do
  let(:client) { test_client }
  describe '#account' do
    before { stub_get('/account').to_return(body: fixture('account.xml')) }
    it 'returns an account element' do
      expect(client.account['account']).to include 'id', 'contact', 'organization'
    end
  end

  describe '#create_customer' do
    before do
      stub_post('/customer')
        .with(
          body: File.read(fixture_path + '/create_customer.xml'),
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Basic dXNlcjpwYXNz',
            'User-Agent' => 'Ruby PortfolioManager API Client',
            'Content-Type' => 'application/xml'
          }
        )
        .to_return(body: fixture('/create_customer_response.xml'))
    end

    it 'creates a property use and returns an id' do
      post_data = File.read(fixture_path + '/create_customer.xml')
      new_customer = client.create_customer(post_data)

      expect(new_customer['response']['id']).to eq('23421')
    end
  end

  describe '#property_list' do
    let(:id) { 680_01 }
    before do
      stub_get("/account/#{id}/property/list").to_return(body: fixture('property_list.xml'))
    end
    it 'returns a list of properties' do
      client.property_list(id)['response']['links']['link'].each do |link|
        expect(link).to include '@id', '@link'
      end
    end
  end
end
