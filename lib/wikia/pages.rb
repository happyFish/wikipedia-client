module Wikia
  class Pages

    def initialize(json)
      require 'json'
      @json = json
      @data = JSON::load(json)
    end

    def all
      @data['query']['allpages'].map {|item|  item['title'] }
    end

    
    

  end
end