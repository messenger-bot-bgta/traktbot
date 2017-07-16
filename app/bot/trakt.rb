class Trakt
  include HTTParty

  base_uri 'https://api.trakt.tv'

  def initialize(params)
    self.class.headers 'Content-Type' => 'application/json'
    self.class.headers 'trakt-api-version' => '2'
    self.class.headers 'trakt-api-key' => '58204fc7a1d802e428755a14e4ce59840dcc1b8ac6add88ead921e8f129b71c1'
  end
  
  def trendings
    self.class.get('/movies/trending').first
  end

end
