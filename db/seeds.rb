require 'faker'

puts "*** Destroying All ***"
Participation.destroy_all
Round.destroy_all
Game.destroy_all
User.destroy_all

VALID_KATA_ID = [
  "59342039eb450e39970000a6",
  "565f5825379664a26b00007c",
  "544675c6f971f7399a000e79",
  "59fca81a5712f9fa4700159a",
  "5601409514fc93442500010b",
  "5875b200d520904a04000003",
  "51c8991dee245d7ddf00000e",
  "56f69d9f9400f508fb000ba7",
]

puts "_________________________________________"

puts "Default ADMIN Devise user ( login purpose ):"
puts "test@test.com"
puts "pass: 123456"
User.create!(
  email: "test@test.com",
  password: "123456",
  nickname: "admin_nickname",
  admin: true
)

puts "_________________________________________"

puts "Creating n°10 Users"
10.times do |i|
  u = User.create!(
    email:    "test#{i}@test.com",
    password: "123456",
    nickname: Faker::Superhero.name
  )
  u.fetch_api_codewars_user_info
  puts "#{i}. #{u.email} - #{u.nickname}"
end

puts "_________________________________________"
puts ""

puts "Creating n°3 Games *with WINNER*"
3.times do |i|
  g = Game.create!(
    title:      Faker::DcComics.title,
    max_rounds: rand(1..4),
    notes:      Faker::Lorem.paragraph,
    user:       User.all.sample # winner
  )
  puts "GAME #{i}. #{g.title}"

  puts ""

  puts "> Creating 3..5 *COMPLETED* Rounds for #{g.title}"
  rand(3..5).times do |i|

    winners_array = []
    rand(2..8).times do
      winners_array << User.all.sample.id
    end

    r = Round.create!(
      kata_id:  VALID_KATA_ID.sample,
      duration: Time.now.sec + rand(0..20),
      notes:    Faker::Lorem.paragraph,
      game:     g,
      active:   false,
      winners:  winners_array.uniq
    )
    puts " - #{i}. Kata_id: #{r.kata_id}"
    r.fetch_api_codewars_kata_info
  end
  puts "_________________________________________"
end

puts "_________________________________________"
puts ""

puts "Creating n°2 Games *NO WINNER yet*"
2.times do |i|
  g = Game.create!(
    title:      Faker::DcComics.title,
    max_rounds: rand(1..4),
    notes:      Faker::Lorem.paragraph
  )
  puts "GAME #{i}. #{g.title}"

  puts ""

  puts "> Creating 2..3 *COMPLETED* Rounds for #{g.title}"
  rand(2..3).times do |i|

    winners_array = []
    rand(2..8).times do
      winners_array << User.all.sample.id
    end

    r = Round.create!(
      kata_id:  VALID_KATA_ID.sample,
      duration: Time.now.sec + rand(0..20),
      notes:    Faker::Lorem.paragraph,
      game:     g,
      active:   false,
      winners:  winners_array.uniq
    )
    puts " - #{i}. Kata_id: #{r.kata_id}"
    r.fetch_api_codewars_kata_info
  end

  puts ""

  puts "> Creating 2..4 *NOT completed* Rounds for #{g.title}"
  rand(2..4).times do |i|
    r = Round.create!(
      kata_id: VALID_KATA_ID.sample,
      notes:   Faker::Lorem.paragraph,
      game:    Game.all.sample
    )
    puts " - #{i}. Kata_id: #{r.kata_id}"
    r.fetch_api_codewars_kata_info
  end
  puts "_________________________________________"
end

puts "_________________________________________"
puts ""

puts "Creating lots of PARTICIPATIONS for each Round"
Round.all.each do |round|
  rand(3..12).times do
    Participation.create!(
      active: [true,false].sample,
      done:   [true,false].sample,
      user:   User.all.sample,
      round:  round
    )
  end
end

puts "_________________________________________"


#______________________________________________________________
# DB.LEWAGON:COM

# <?xml version="1.0" encoding="utf-8" ?>
# <!-- SQL XML created by WWW SQL Designer, https://github.com/ondras/wwwsqldesigner/ -->
# <!-- Active URL: https://kitt.lewagon.com/db/2341 -->
# <sql>
# <datatypes db="postgresql">
#   <group label="Numeric" color="rgb(238,238,170)">
#     <type label="Integer" length="0" sql="INTEGER" re="INT" quote=""/>
#     <type label="Small Integer" length="0" sql="SMALLINT" quote=""/>
#     <type label="Big Integer" length="0" sql="BIGINT" quote=""/>
#     <type label="Decimal" length="1" sql="DECIMAL" re="numeric" quote=""/>
#     <type label="Serial" length="0" sql="SERIAL" re="SERIAL4" fk="Integer" quote=""/>
#     <type label="Big Serial" length="0" sql="BIGSERIAL" re="SERIAL8" fk="Big Integer" quote=""/>
#     <type label="Real" length="0" sql="BIGINT" quote=""/>
#     <type label="Single precision" length="0" sql="FLOAT" quote=""/>
#     <type label="Double precision" length="0" sql="DOUBLE" re="DOUBLE" quote=""/>
#   </group>

#   <group label="Character" color="rgb(255,200,200)">
#     <type label="Char" length="1" sql="CHAR" quote="'"/>
#     <type label="Varchar" length="1" sql="VARCHAR" re="CHARACTER VARYING" quote="'"/>
#     <type label="Text" length="0" sql="TEXT" quote="'"/>
#     <type label="Binary" length="1" sql="BYTEA" quote="'"/>
#     <type label="Boolean" length="0" sql="BOOLEAN" quote="'"/>
#   </group>

#   <group label="Date &amp; Time" color="rgb(200,255,200)">
#     <type label="Date" length="0" sql="DATE" quote="'"/>
#     <type label="Time" length="1" sql="TIME" quote="'"/>
#     <type label="Time w/ TZ" length="0" sql="TIME WITH TIME ZONE" quote="'"/>
#     <type label="Interval" length="1" sql="INTERVAL" quote="'"/>
#     <type label="Timestamp" length="1" sql="TIMESTAMP" quote="'"/>
#     <type label="Timestamp w/ TZ" length="0" sql="TIMESTAMP WITH TIME ZONE" quote="'"/>
#     <type label="Timestamp wo/ TZ" length="0" sql="TIMESTAMP WITHOUT TIME ZONE" quote="'"/>
#   </group>

#   <group label="Miscellaneous" color="rgb(200,200,255)">
#     <type label="XML" length="1" sql="XML" quote="'"/>
#     <type label="Bit" length="1" sql="BIT" quote="'"/>
#     <type label="Bit Varying" length="1" sql="VARBIT" re="BIT VARYING" quote="'"/>
#     <type label="Inet Host Addr" length="0" sql="INET" quote="'"/>
#     <type label="Inet CIDR Addr" length="0" sql="CIDR" quote="'"/>
#     <type label="Geometry" length="0" sql="GEOMETRY" quote="'"/>
#   </group>
# </datatypes><table x="255" y="101" name="GAMES">
# <row name="id" null="1" autoincrement="1">
# <datatype>INTEGER</datatype>
# <default>NULL</default></row>
# <row name="title" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="max_n_rounds" null="1" autoincrement="0">
# <datatype>INTEGER</datatype>
# <default>NULL</default></row>
# <row name="game_winner (user)" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="user_id (winner)" null="1" autoincrement="0">
# <datatype>INTEGER</datatype>
# <default>NULL</default><relation table="USERS" row="id" />
# </row>
# <row name="notes" null="1" autoincrement="0">
# <datatype>TEXT</datatype>
# <default>NULL</default></row>
# <key type="PRIMARY" name="">
# <part>id</part>
# </key>
# <comment>ciao</comment>
# </table>
# <table x="1073" y="102" name="USERS">
# <row name="id" null="1" autoincrement="1">
# <datatype>INTEGER</datatype>
# <default>NULL</default></row>
# <row name="email (device)" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="password (device)" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="nickname" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="avatar (cloudinary)" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <key type="PRIMARY" name="">
# <part>id</part>
# </key>
# </table>
# <table x="751" y="301" name="PARTICIPATIONS/attempts">
# <row name="id" null="1" autoincrement="1">
# <datatype>INTEGER</datatype>
# <default>NULL</default></row>
# <row name="user_id" null="1" autoincrement="0">
# <datatype>INTEGER</datatype>
# <default>NULL</default><relation table="USERS" row="id" />
# </row>
# <row name="round_id" null="1" autoincrement="0">
# <datatype>INTEGER</datatype>
# <default>NULL</default><relation table="ROUNDS" row="id" />
# </row>
# <row name="active (boolean - can play next round?)" null="1" autoincrement="0">
# <datatype>BOOLEAN</datatype>
# <default>NULL</default></row>
# <row name="done? (Kata API response - check if current kata is completed or not)" null="1" autoincrement="0">
# <datatype>BOOLEAN</datatype>
# <default>NULL</default></row>
# <key type="PRIMARY" name="">
# <part>id</part>
# </key>
# </table>
# <table x="454" y="301" name="ROUNDS">
# <row name="id" null="1" autoincrement="1">
# <datatype>INTEGER</datatype>
# <default>NULL</default></row>
# <row name="game_id" null="1" autoincrement="0">
# <datatype>INTEGER</datatype>
# <default>NULL</default><relation table="GAMES" row="id" />
# </row>
# <row name="kata_info...." null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="round_winners [array of users]" null="1" autoincrement="0">
# <datatype>CHAR</datatype>
# <default>NULL</default></row>
# <row name="round_duration" null="1" autoincrement="0">
# <datatype>TIME</datatype>
# <default>NULL</default></row>
# <key type="PRIMARY" name="">
# <part>id</part>
# </key>
# </table>
# </sql>
