require 'spec_helper'

describe GoogleMapsService::Apis::Place do
  include_context 'HTTP client'

  context '#find_place' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/findplacefromtext\/.*/)
        .to_return(
          :status => 200,
          headers: { 'Content-Type' => 'application/json' },
          body: '{"status":"OK","candidates":[]}'
        )
    end

    context 'find_place' do
      it 'should call Google Maps Web Service' do
        results = client.find_place('foo', 'textquery')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=#{api_key}&input=foo&inputtype=textquery")).to have_been_made
      end
    end
  end

  context '#nearby_search' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/nearbysearch\/.*/)
        .to_return(
          :status => 200,
          headers: { 'Content-Type' => 'application/json' },
          body: '{"html_attributions": [],"results":[], "status": "OK"}')
    end

    context 'single point' do
      it 'should call Google Maps Web Service with single point' do
        results = client.nearby_search('-33.8587323,151.2100055')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{api_key}&location=-33.8587323%2C151.2100055")).to have_been_made
      end
    end
  end

  context '#text_search' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/textsearch\/.*/)
        .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"html_attributions": [],"results":[], "status": "OK"}')
    end

    context 'text search' do
      it 'should call Google Maps Web Service' do
        results = client.text_search('123 main street')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/textsearch/json?key=#{api_key}&query=123%20main%20street")).to have_been_made
      end
    end
  end

  context '#place_details' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/details\/.*/)
        .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"html_attributions": [],"results":{}, "status": "OK"}')
    end

    context 'Place details' do
      it 'should call Google Maps Web Service' do
        results = client.place_details('ChIJN1t_tDeuEmsRUsoyG83frY4')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=#{api_key}&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4")).to have_been_made
      end
    end
  end

  # context '#place_photos' do
  #   before(:example) do
  #     stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/photo\/.*/)
  #       .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"html_attributions": [],"results":{}, "status": "OK"}')
  #   end

  #   context 'Place photo' do
  #     it 'should call Google Maps Web Service' do
  #       results = client.place_photos('Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT')
  #       expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/photo/json?key=#{api_key}&photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT")).to have_been_made
  #     end
  #   end
  # end

  context '#place_autocomplete' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/autocomplete\/.*/)
        .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"predictions": [],"status": "OK"}')
    end

    context 'Place autocomplete' do
      it 'should call Google Maps Web Service' do
        results = client.place_autocomplete('amoeba')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=#{api_key}&input=amoeba")).to have_been_made
      end
    end
  end

  context '#query_autocomplete' do
    before(:example) do
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/queryautocomplete\/.*/)
        .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"predictions": [],"status": "OK"}')
    end

    context 'Query autocomplete' do
      it 'should call Google Maps Web Service' do
        results = client.query_autocomplete('Pizza near Par')
        expect(a_request(:get, "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=#{api_key}&input=Pizza%20near%20Par")).to have_been_made
      end
    end
  end
end
