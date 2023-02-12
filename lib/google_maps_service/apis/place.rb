module GoogleMapsService::Apis

  # Performs requests to the Google Maps Place API.
  module Place

    # Privides place information using a variety of categories, including establishments,
    # prominent points of interest, and geographic locations.
    #
    # @example Find places based on name or address request inclluding photos,
    # formatted_address, name, rating, opening_hours, and geometry fields.
    #   candidates = client.find_place(
    #     'Museum of Contemporary Art Australia',
    #     'textquery',
    #     fields: ['formatted_address', 'name', 'rating', 'opening_hours', 'geometry']
    #   )
    #
    # @example List of places based on phone number request
    #   candidates = client.find_place('+16502530000', 'phonenumber')
    #
    # @param [String] input The text string on which to search, for example: 'restaurant' or
    #                   '123 Main Street'. This must be a place name, address, or category of establishments.
    # @param [String] input_type The text string 'textquery' for searching by location name or address
    #                   or 'phonenumber' for phone number.
    # @param [Array<String>] fields For specifying place data types to return.
    # @param [String] language The language in which to return results.
    # @param [String] location_bias Prefer results in a specified area.
    #
    # @return [Array] Array of candidates.
    def find_place(input, input_type, fields: [], language: nil, location_bias: nil)
      params = {
        input: input,
        inputtype: input_type,
      }

      params[:fields] = fields.join(',') unless fields.empty?
      params[:language] = language if language
      params[:locationbias] = location_bias if location_bias

      get('/maps/api/place/findplacefromtext/json', params)
    end

    # Allows search for places whithit specfic area.
    # @example Find restaurants in radius 1.5km.
    #   result = client.nearby_search(
    #     '-33.8670522,151.1957362',
    #     radius: 1500,
    #     type: 'restaurant',
    #     key_word: 'cruise'
    #   )
    #
    # @param [String] location The point around which to retrieve place information. This must be
    #                   specified as latitude,longitude.
    # @param [Integer] radius Defines the distance (in meters) within which to return place
    #                     results. 50000 by default.
    # @param [String] key_word The text string on which to search, e.g 'restaurant' or '123 Main Street'.
    # @param [String] language The language in which to return results.
    # @param [Integer] max_price Restricts results to only those places within the specified range.
    #                      Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
    # @param [Integer] min_price Restricts results to only those places within the specified range.
    #                      Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
    # @param [Boolean] open_now Returns only those places that are open for business at the time the query is sent.
    # @param [String] page_token Executes a search with the same parameters used previously.
    # @param [String] rank_by Specifies the order in which results are listed. Accepted valuees:
    #                    prominence (by default) or distance.
    # @param [String] type Restricts the results to places matching the specified type.
    #
    # @return [Hash] Response body as hash. The hash key will be symbolized.
    def nearby_search(
      location,
      radius: nil,
      key_word: nil,
      language: nil,
      max_price: nil,
      min_price: nil,
      open_now: nil,
      page_token: nil,
      rank_by: nil,
      type: nil
    )

      params = { location: location }
      params[:radius] = radius if radius
      params[:keyword] = key_word if key_word
      params[:language] = language if language
      params[:maxprice] = max_price if max_price
      params[:minprice] = min_price if min_price
      params[:opennow] = open_now unless open_now.nil?
      params[:pagetoken] = page_token if page_token
      params[:rankby] = rank_by if rank_by
      params[:type] = type if type

      get('/maps/api/place/nearbysearch/json', params)
    end

    # Returns information about a set of places based on a string request e.g. 'pizza in New York' or
    # 'shoe stores near Ottawa' or '123 Main Street'.
    #
    # @example Shows a search for an incomplete address specified by locatoin and radius.
    #   result = client.text_search(
    #     '123 main street',
    #     location: '42.3675294,-71.186966',
    #     radius: 10000
    #   )
    #
    # @param [String] query The text string on which to search, for example: 'restaurant' or '123 Main Street'.
    # @param [Integer] radius Defines the distance (in meters) within which to return place
    #                     results. 50000 by default.
    # @param [String] language The language in which to return results.
    # @param [String] location The point around which to retrieve place information. This must be
    #                   specified as latitude,longitude.
    # @param [Integer] max_price Restricts results to only those places within the specified range.
    #                      Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
    # @param [Integer] min_price Restricts results to only those places within the specified range.
    #                      Valid values range between 0 (most affordable) to 4 (most expensive), inclusive.
    # @param [Boolean] open_now Returns only those places that are open for business at the time the query is sent.
    # @param [String] page_token Executes a search with the same parameters used previously.
    # @param [String] region The region code, specified as a ccTLD ("top-level domain") two-character value.
    # @param [String] type Restricts the results to places matching the specified type.
    #
    # @return [Hash] Response body as hash. The hash key will be symbolized.
    def text_search(
      query,
      radius: nil,
      language: nil,
      location: nil,
      max_price: nil,
      min_price: nil,
      open_now: nil,
      page_token: nil,
      region: nil,
      type: nil
    )

      params = { query: query }
      params[:radius] = radius if radius
      params[:language] = language if language
      params[:location] = location if location
      params[:maxprice] = max_price if max_price
      params[:minprice] = min_price if min_price
      params[:opennow] = open_now unless open_now.nil?
      params[:pagetoken] = page_token if page_token
      params[:region] = region if region
      params[:type] = type if type

      get('/maps/api/place/textsearch/json', params)
    end

    # Returns more comprehensive information about the indicated place such as its complete address, phone
    # number, user rating and reviews.
    #
    # @example Shows the details of a place by place_id, and includes the name, rating, and
    # formatted_phone_number fields.
    #   result = client.place_details(
    #     'ChIJN1t_tDeuEmsRUsoyG83frY4',
    #     fields: ['name', 'rating', 'formatted_phone_number']
    #   )
    #
    # @param [String] place_id A textual identifier that uniquely identifies a place, returned from a Place Search.
    # @param [Array<String>] fields For specifying place data types to return.
    # @param [String] region The region code, specified as a ccTLD ("top-level domain") two-character value.
    # @param [Boolean] reviews_no_translations Specify to disable translation of reviews.
    # @param [String] reviews_sort The sorting method to use when returning reviews. Can be set to most_relevant
    #                   (default) or newest.
    # @param [String] session_token A random string which identifies an autocomplete session for billing purposes.
    #
    # @return [Hash] Response body as hash. The hash key will be symbolized.
    def place_details(
      place_id,
      language: nil,
      fields: [],
      region: nil,
      reviews_no_translations: nil,
      reviews_sort: nil,
      session_token: nil
    )

      params = { place_id: place_id }
      params[:language] = language if language
      params[:fields] = fields.join(',') unless fields.empty?
      params[:region] = region if region
      params[:reviews_no_translations] = reviews_no_translations unless reviews_no_translations.nil?
      params[:reviews_sort] = reviews_sort if reviews_sort
      params[:sessiontoken] = session_token if session_token

      get('/maps/api/place/details/json', params)
    end

    # Returns quality photographic content.
    #
    # @example Return the referenced image, resizing it so that it is at most 400 pixels wide.
    #   result = client.place_photos(
    #     'Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT',
    #     maxwidth: 400
    #   )
    #
    # @param [String] photo_reference A string identifier that uniquely identifies a photo. Photo references
    #                    are returned from either a Place Search or Place Details request.
    # @param [Integer] max_height Specifies the maximum desired height, in pixels, of the image.
    # @param [Integer] max_width Specifies the maximum desired width, in pixels, of the image.
    #
    # @return [Array] Array of photos.
    def place_photos(photo_reference, max_height: nil, max_width: nil)
      params = { photo_reference: photo_reference }
      params[:maxheight] = max_height if max_height
      params[:maxwidth] = max_width if max_width

      get('/maps/api/place/photo', params)
    end

    # Returns place predictions
    # @example Returns results for establishments containing the string "Amoeba" within an area centered in
    # San Francisco, CA:
    #   result = client.place_autocomplete(
    #     'amoeba',
    #     types: 'establishment',
    #     location: '37.76999,-122.44696',
    #     radius: 500
    #   )
    #
    # @param [String] input The text string on which to search.
    # @param [Integer] radius Defines the distance (in meters) within which to return place
    #                     results. 50000 by default.
    # @param [Integer] components A grouping of places to which you would like to restrict your results.
    #                      Countries must be passed as a two character, ISO 3166-1 Alpha-2 compatible country code.
    #                      For example: components=country:us|country:pr|country:vi|country:gu|country:mp would
    #                      restrict your results to places within the United States and its unincorporated organized
    #                      territories.
    # @param [String] language The language in which to return results.
    # @param [String] location The point around which to retrieve place information. This must be
    #                   specified as latitude,longitude.
    # @param [String] location_bias Prefer results in a specified area.
    # @param [String] location_restriction Restrict results to a specified area, by specifying either a radius
    #                   plus lat/lng, or two lat/lng pairs representing the points of a rectangle.
    # @param [String] offset The position, in the input term, of the last character that the service uses to match
    #                   predictions. For example, if the input is Google and the offset is 3, the service
    #                   will match on Goo.
    # @param [String] origin The origin point from which to calculate straight-line distance to the destination.
    #                   Must be specified as latitude,longitude.
    # @param [String] region The region code, specified as a ccTLD ("top-level domain") two-character value.
    # @param [String] session_token A random string which identifies an autocomplete session for billing purposes.
    # @param [String] strict_bounds Returns only those places that are strictly within the region defined
    #                   by location and radius.
    # @param [String] types Allows restrict results from a Place Autocomplete request to be of a certain type
    #                   by passing the types parameter.
    #
    # @return [Array] Array of predictions.
    def place_autocomplete(
      input,
      radius: nil,
      components: nil,
      language: nil,
      location: nil,
      location_bias: nil,
      location_restriction: nil,
      offset: nil,
      origin: nil,
      region: nil,
      session_token: nil,
      strict_bounds: nil,
      types: nil
    )

      params = { input: input }
      params[:radius] = radius if radius
      params[:components] = components if components
      params[:language] = language if language
      params[:location] = location if location
      params[:locationbias] = location_bias if location_bias
      params[:locationrestriction] = location_restriction if location_restriction
      params[:offset] = offset if offset
      params[:origin] = origin if origin
      params[:region] = region if region
      params[:sessiontoken] = session_token if session_token
      params[:strictbounds] = strict_bounds if strict_bounds
      params[:types] = types if types

      get('/maps/api/place/autocomplete/json', params)
    end

    # Provide a query prediction for text-based geographic searches, by returning suggested queries as you type.
    #
    # @example Returns results for a request "Pizza near Par", with results in French:
    #   result = client.place_autocomplete(
    #     'Pizza near Par',
    #     language: 'fr'
    #   )
    #
    # @param [String] input The text string on which to search.
    # @param [Integer] radius Defines the distance (in meters) within which to return place
    #                     results. 50000 by default.
    # @param [String] language The language in which to return results.
    # @param [String] location The point around which to retrieve place information. This must be
    #                   specified as latitude,longitude.
    # @param [String] offset The position, in the input term, of the last character that the service uses to match
    #                   predictions. For example, if the input is Google and the offset is 3, the service
    #                   will match on Goo.
    #
    # @return [Array] Array of predictions.
    def query_autocomplete(input, radius: nil, language: nil, location: nil, offset: nil)
      params = { input: input }
      params[:radius] = radius if radius
      params[:language] = language if language
      params[:location] = location if location
      params[:offset] = offset if offset

      get('/maps/api/place/queryautocomplete/json', params)
    end
  end
end
