class BreweryAPI
  def initialize(url)
    @url = url
  end

  def get_by_location(user_loc)
    RestClient.get "#{@url}?by_city=#{user_loc}&per_page=50 "
  end
end
