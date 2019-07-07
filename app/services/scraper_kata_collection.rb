require 'open-uri'
require 'nokogiri'
require 'pry'

class ScraperKataCollection

  BASE_URL       = "https://www.codewars.com"
  COLLECTION_URL = "https://www.codewars.com/collections/"

  def self.get_titles_and_hrefs(coll_ref) # Full URL (www..) or just ID (katas-51)
  # _RETURN_ an [ array ] of { hashes }

    url = coll_ref.include?("www") ? coll_ref : COLLECTION_URL + coll_ref
    html_doc = Nokogiri::HTML(open(url).read)

    html_doc.search('.item-title a').map do |element|
      {
        title: element.text.strip,
        href:  element.attribute('href').value
      }
      # {:title=>"Playing with digits", :href=>"/kata/5552101f47fc5178b1000050"}
    end
  end

end # of class
