require 'open-uri'
require 'nokogiri'

class ScraperKataCollection

  BASE_URL       = "https://www.codewars.com"
  COLLECTION_URL = "https://www.codewars.com/collections"

  def self.get_titles_and_hrefs(coll_ref, output = "rb") # Full URL (www..) or just ID (katas-51)
    # "rb" => _RETURN_ an [ array ] of { hashes }
    # "js" => _RETURN_ an [ array ] of [ arrays ]

    url = coll_ref.include?("www") ? coll_ref : BASE_URL + coll_ref

    begin
      html_doc = Nokogiri::HTML(open(url).read)
    rescue
      puts "\n\nURL (collection_reference) is NOT VALID in #{self}\n\n"
      return
    end

    html_doc.search('.item-title a').map do |element|
      if output == "rb"
        {
          title: element.text.strip,
          href:  element.attribute('href').value
        }
      elsif output == "js"
        [ element.text.strip, element.attribute('href').value ]
      end
    end
    # => [{:title=>"ToDo", :href=>"/collections/todo-998"},
    # {:title=>"LFC37", :href=>"/users/LFC37"},
    # {:title=>"Calculate BMI", :href=>"/kata/57a429e253ba3381850000fb"},
    # {:title=>"Array plus array", :href=>"/kata/5a2be17aee1aaefe2a000151"},
    # {:title=>"Calculate average", :href=>"/kata/57a2013acf1fa5bfc4000921"}]
  end

  def self.filter_by_kyu(kyu1, kyu2 = nil) # KYU is kata lvl (8 or 6 etc..)
    # _RETURN_ [ array ] of "collection_href"

    begin
      html_doc = Nokogiri::HTML(open(COLLECTION_URL).read)
    rescue
      puts "\n\nNokogiri::HTML(open(COLLECTION_URL).read) FAILED TO RUN in #{self}\n\n"
      return
    end

    if kyu2.nil?
      return html_doc.search('span.has-tip')
        .select { |e| e.text.include?("#{kyu1} kyu") }
        .map { |e| e.parent.parent.search("a").attribute('href').value }
    end

    result = []
    result << html_doc.search('span.has-tip')
      .select { |e| e.text.include?("#{kyu1} kyu") }
      .map { |e| e.parent.parent.search("a").attribute('href').value }
    result << html_doc.search('span.has-tip')
      .select { |e| e.text.include?("#{kyu2} kyu") }
      .map { |e| e.parent.parent.search("a").attribute('href').value }

    result.flatten
    # ["/collections/kyu8", "/collections/good-problem-for-beginner", ...]
  end

end
