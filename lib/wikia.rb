Dir[File.dirname(__FILE__) + '/wikia/**/*.rb'].each { |f| require f }

require 'uri'

module Wikia
  # Examples : 
  # page = Wikia.find('Rails') 
  # => #<Wikia:0x123102>
  # page.content
  # => wiki content appears here
  
  # basically just a wrapper for doing 
  # client = Wikia::Client.new
  # client.find('Rails')
  #
  def self.find( page, options = {} )
    client.find( page, options )
  end

  def self.find_image( title, options = {} )
    client.find_image( title, options )
  end

  def self.categories(options = {})
    client.categories || client.list_categories(options)
  end

  def self.pages(options = {})
    client.pages || client.all_pages(options)
  end

  def self.seasons
    self.categories.find_all{ |category| category.include?("Season") || category.include?("season")  }
  end

  def self.episodes(season = nil)
    episodes = []

    episodes = Wikia::Categories.find('Episodes')

    return episodes unless episodes.empty?

    self.seasons.each do |season|
      eps_in_season = client.find(season).links
      episodes += eps_in_season unless eps_in_season.nil?
    end

    puts episodes

    episodes.uniq!

  end

  def self.characters
    Wikia::Categories.find('Characters')
  end

  def self.actors
    Wikia::Categories.find('Actors')
  end
  
  def self.Configure(&block)
    Configuration.instance.instance_eval(&block)
  end
  
  Configure {
    protocol  'http'
    domain    'sopranos.wikia.com'
    path      'api.php'
  }

  private

  def self.client
    @client ||= Wikia::Client.new
  end
end
