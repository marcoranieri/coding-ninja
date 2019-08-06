require 'open-uri'
require 'json'

class ApiFetchCompletedChallenges
  BASE_URL = "https://www.codewars.com/api/v1/users/"

  def self.fetch_last_id(username, api_key)
    url = BASE_URL + "#{username}/code-challenges/completed?page=0?access_key=#{api_key}"
    JSON.parse(open(url).read)["data"].first["id"]
    # RETURN _STRING_ of last completed kata id => "58f5c63f1e26ecda7e000029"
  end

end

# p ApiFetchCompletedChallenges.fetch_last_id("marcoranieri", "qsoyRuWkzMk6e5xZuey7")
