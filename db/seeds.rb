# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   Mayor.create(name: 'Emanuel', city: cities.first)


# countries = {"DZ" => "ALGERIA", "AT" => "AUSTRIA", "AU" => "AUSTRALIA", "AR" => "ARGENTINA", "BH" => "BAHRAIN", "BE" => "BELGIUM", "BR" => "BRAZIL", "CA" => "CANADA", "CL" => "CHILE", "CO" => "COLOMBIA", "CZ" => "CZECH REPUBLIC", "DK" => "DENMARK", "EG" => "EGYPT", "FI" => "FINLAND", "FR" => "FRANCE", "DE" => "GERMANY", "GH" => "GHANA", "GR" => "GREECE", "HK" => "HONG KONG", "HU" => "HUNGARY", "IN" => "INDIA", "ID" => "INDONESIA", "IE" => "IRELAND", "IL" => "ISRAEL", "IT" => "ITALY", "JP" => "JAPAN", "JO" => "JORDAN", "KE" => "KENYA", "KR" => "SOUTH KOREA", "KW" => "KUWAIT", "MY" => "MALAYSIA", "MX" => "MEXICO", "MA" => "MOROCCO", "NL" => "NETHERLANDS", "NO" => "NORWAY", "OM" => "OMAN", "PE" => "PERU", "PH" => "PHILIPPINES", "PL" => "POLAND", "PT" => "PORTUGAL", "QA" => "QATAR", "RO" => "ROMANIA", "RU" => "RUSSIA", "SA" => "SAUDI ARABIA", "SN" => "SENEGAL", "SG" => "SINGAPORE", "SK" => "SLOVAKIA", "ZA" => "SOUTH AFRICA", "ES" => "SPAIN", "SE" => "SWEDEN", "CH" => "SWITZERLAND", "TW" => "TAIWAN", "TN" => "TUNISIA", "TR" => "TURKEY", "UG" => "UGANDA", "UA" => "UKRAINE", "AE" => "UNITED ARAB EMIRATES", "GB" => "UNITED KINGDOM", "US" => "UNITED STATES", "YE" => "YEMEN"}
# country_map_id_hash = {"DZ"=>12, "YE"=>887, "AT"=>40, "AU"=>36, "AR"=>32, "BH"=>48, "BE"=>56, "BR"=>76, "CA"=>124, "CL"=>152, "CO"=>170, "CZ"=>203, "DK"=>208, "EG"=>818, "FI"=>246, "FR"=>250, "DE"=>276, "GH"=>288, "GR"=>300, "HK"=>344, "HU"=>348, "IN"=>356, "ID"=>360, "IE"=>372, "IL"=>376, "IT"=>380, "JP"=>392, "JO"=>400, "KE"=>404, "KR"=>410, "KW"=>414, "MY"=>458, "MX"=>484, "MA"=>504, "NL"=>528, "NO"=>578, "OM"=>512, "PE"=>604, "PH"=>608, "PL"=>616, "PT"=>620, "QA"=>634, "RO"=>642, "RU"=>643, "SA"=>682, "SN"=>686, "SG"=>702, "SK"=>703, "ZA"=>710, "ES"=>724, "SE"=>752, "CH"=>756, "TW"=>158, "TN"=>788, "TR"=>792, "UG"=>800, "UA"=>804, "AE"=>784, "GB"=>826, "US"=>840}

# country_map_id_hash = {"DZ"=>12, "YE"=>887, "AT"=>40, "AU"=>36, "AR"=>32, "BH"=>48, "BE"=>56, "BR"=>76, "CA"=>124, "CL"=>152, "CO"=>170, "CZ"=>203, "DK"=>208, "EG"=>818, "FI"=>246, "FR"=>250, "DE"=>276, "GH"=>288, "GR"=>300, "HK"=>344, "HU"=>348, "IN"=>356, "ID"=>360, "IE"=>372, "IL"=>376, "IT"=>380, "JP"=>392, "JO"=>400, "KE"=>404, "KR"=>410, "KW"=>414, "MY"=>458, "MX"=>484, "MA"=>504, "NL"=>528, "NO"=>578, "OM"=>512, "PE"=>604, "PH"=>608, "PL"=>616, "PT"=>620, "QA"=>634, "RO"=>642, "RU"=>643, "SA"=>682, "SN"=>686, "SG"=>702, "SK"=>703, "ZA"=>710, "ES"=>724, "SE"=>752, "CH"=>756, "TW"=>158, "TN"=>788, "TR"=>792, "UG"=>800, "UA"=>804, "AE"=>784, "GB"=>826, "US"=>840}

# countries.each do |code, name|
#   flag_url = "http://flagpedia.net/data/flags/normal/#{code.downcase}.png"
#   # pop = population[name].gsub(',', '').to_i
#   Country.create(code: code, name: name, flag_url: flag_url, map_id: country_map_id_hash[code])

# end


# Populate the database with data parsed from HTTParty
def populate_db

  continents = ["oceania", "africa", "asia", "europe", "north_america", "south_america"]

  valid_map_ids = [36, 554, 818, 12, 504, 434, 710, 566, 288, 156, 360, 392, 458, 608, 764, 704, 410, 792, 368, 760, 376, 275, 422, 51, 356, 586, 364, 4, 398, 276, 250, 528, 56, 40, 756, 826, 752, 208, 578, 246, 372, 352, 380, 724, 300, 643, 804, 616,  642, 203, 348, 840, 124, 484, 76, 32, 604, 862, 152, 170]

  continents.each do |continent|
  results = HTTParty.get("http://www.pornmd.com/geosearches?continent=" + continent)

  # The HTTParty result is a JSON object with a hash
  # key of countries and the hash value an array of
  # results.
  #
  # The FIRST item in the results hash is the most
  # popular. 
  #
  # I flattened the results array with the join
  # command and then store the new entry
  results.each do |result|
  puts continent + ":" + result[0] + " Terms: " + result[1].join(",")

  new_entry = Country.new
  new_entry[:name] = result[0]
  new_entry[:searches] = result[1].join(",")
    valid_map_ids.each do |id|
      new_entry[:map_id] = id
    end
  new_entry.save
  end
  end

end

populate_db




# Country.all.each do |country|
#   # grab top videos for country here
#   country_code = country.code
#   num = 10
#   url = "http://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular?v=2&time=today&max-results=#{num}"

#   results = HTTParty.get(url).body
#   results_json = Hash.from_xml(results)

#   results_json["feed"]["entry"].each do |entry|

#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: true
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

#   # categories = ["News", "Music", "Entertainment", "Tech", "Animals"]
#   news_url = "https://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular_News?v=2&time=today&max-results=10"
#   music_url = "https://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular_Music?v=2&time=today&max-results=#{num}"
#   entertainment_url = "https://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular_Entertainment?v=2&time=today&max-results=#{num}"
#   tech_url = "https://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular_Tech?v=2&time=today&max-results=#{num}"
#   animals_url = "https://gdata.youtube.com/feeds/api/standardfeeds/#{country_code}/most_popular_Animals?v=2&time=today&max-results=#{num}"

#   news_results = HTTParty.get(news_url).body
#   news_results_json = Hash.from_xml(news_results)

#   news_results_json["feed"]["entry"].each do |entry|
#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: false
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

#   music_results = HTTParty.get(music_url).body
#   music_results_json = Hash.from_xml(music_results)

#   music_results_json["feed"]["entry"].each do |entry|
#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: false
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

#   entertainment_results = HTTParty.get(entertainment_url).body
#   entertainment_results_json = Hash.from_xml(entertainment_results)

#   entertainment_results_json["feed"]["entry"].each do |entry|
#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: false
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

#   tech_results = HTTParty.get(tech_url).body
#   tech_results_json = Hash.from_xml(tech_results)

#   tech_results_json["feed"]["entry"].each do |entry|
#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: false
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

#   animals_results = HTTParty.get(animals_url).body
#   animals_results_json = Hash.from_xml(animals_results)

#   animals_results_json["feed"]["entry"].each do |entry|
#     if big_url_cnt = entry["content"]
#       big_url = big_url_cnt['src']

#       if Video.exists?(big_url: big_url)
#         vid = Video.where(big_url: big_url).first
#       else
#         vid = Video.new(
#           # get relevant video attributes from results_json
#           title: entry["title"],
#           normal_url: entry["link"].first["href"],
#           big_url: entry["content"]["src"],
#           term: entry["category"][1]["term"],
#           thumbnail_url: entry["group"]["thumbnail"][0]["url"],
#           top: false
#         )
#         embeddable_url = vid.youtube_embed
#         vid.embed_url = embeddable_url
#         vid.save
#       end

#       puts CountryVideo.create(country_id: country.id, video_id: vid.id)
#     end
#   end

# end