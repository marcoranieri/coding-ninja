require 'open-uri'
require 'json'

class CodewarsApiFetch

  BASE_URL = "https://www.codewars.com/api/v1/users/"

  # FETCH the last KATA_ID of 'COMPLETED' Challenges
  def self.last_completed_id(username, api_key)
    # RETURN _STRING_ => "58f5c63f1e26ecda7e000029"
    url = BASE_URL + "#{username}/code-challenges/completed?page=0?access_key=#{api_key}"
    JSON.parse(open(url).read)["data"].first["id"]
  end

  def self.kata_info(kata_ref) # kata_ref = "/57a429e253ba3381850000fb"
    url = "https://www.codewars.com/api/v1/code-challenges#{kata_ref}"
    JSON.parse(open(url).read)
    # puts JSON.pretty_generate(JSON.parse(open(url).read))
  end

end

# p CodewarsApiFetch.last_completed_id("marcoranieri", "qsoyRuWkzMk6e5xZuey7")
# CodewarsApiFetch.kata_info("/57a429e253ba3381850000fb")
