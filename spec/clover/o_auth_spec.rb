require 'spec_helper'

describe Clover::OAuth do
  context 'without redirect URI' do
    it 'fails' do
      expect { Clover::OAuth.authorize_url }.to raise_exception ArgumentError
    end
  end

  context 'with redirect URI' do
    configure_clover oauth_redirect_uri: 'https://localhost:3000', client_id: 'theappid'

    it 'generates valid uri' do
      expect(Clover::OAuth.authorize_url).to match %r{sandbox\.dev\.clover\.com/oauth/authorize\?client_id=theappid}
    end

    it 'generates valid token' do
      expect(Clover::OAuth.get_token 'abc123').to eq 'fakeresponseapikey'
      expect(Clover.configuration.api_token).to eq 'fakeresponseapikey'
    end
  end
end
