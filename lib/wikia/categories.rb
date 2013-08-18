module Wikia
  class Categories

    def initialize(json)
      require 'json'
      @json = json
      @data = JSON::load(json)
    end

    def all
      @data['query']['allcategories'].map {|item|  item['*'] }
    end

    def self.find( category_title, options = {} )

      request = client.request({
          :action => "query",
          :list => 'categorymembers',
          :cmtitle => "Category:#{category_title}",
          :cmlimit => 500
        }.merge(options) 
      )

      categories = Categories.new( request )

      cats_data = categories.instance_variable_get(:@data)['query']['categorymembers']

      if cats_data.empty?
        return []
      else
        cats_data.map {|item|  item['title'] }
      end

    end


    private

    def self.client
      @client ||= Wikia::Client.new
    end

    
  end
end