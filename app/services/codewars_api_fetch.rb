require 'open-uri'
require 'json'

class CodewarsApiFetch

  BASE_URL = "https://www.codewars.com/api/v1/users/"

  # FETCH 'COMPLETED' Challenges from Username
  def self.completed_kata(username,api_key,args={})
    # RETURN _JSON_ of all completed kata from one user
    # *if args[:only_last] = true* RETURN _STRING_ => "58f5c63f1e26ecda7e000029"
    api_key = "qsoyRuWkzMk6e5xZuey7" if api_key.nil?

    url = BASE_URL + "#{username}/code-challenges/completed?page=0?access_key=#{api_key}"

    begin
      response = JSON.parse(open(url).read)
      args[:only_last] ? response["data"].first["id"] : response
    rescue
      return
    end
  end

  def self.kata_info(kata_ref) # kata_ref = "57a429e253ba3381850000fb"
    url = "https://www.codewars.com/api/v1/code-challenges/#{kata_ref}"
    begin
    # puts JSON.pretty_generate(JSON.parse(open(url).read))
      JSON.parse(open(url).read)
    rescue
      return
    end
  end

end

# p CodewarsApiFetch.completed_kata("marcoranieri", "qsoyRuWkzMk6e5xZuey7")
# p CodewarsApiFetch.completed_kata("marcoranieri", "qsoyRuWkzMk6e5xZuey7", only_last: true)
# CodewarsApiFetch.kata_info("57a429e253ba3381850000fb")
