require 'json'
require 'sqlite3'
require_relative './no-to-ayat-symbol.rb'
require_relative './sura_name_translator.rb'

begin
    db = SQLite3::Database.open "quran_indo.db"
    f = File.open("ayat.txt", 'w:UTF-8')

    sura_ayat = JSON.parse(File.open('ayat_no.json', 'r').read)

    stm = db.prepare "SELECT Text FROM VERSES WHERE sura = :sura AND ayah = :ayah"

    sura_ayat.each do |sura, ayats|
        f.puts key_to_sura_name(sura)
        ayats.each do |ayat|
            rs = stm.execute key_to_no(sura)+1, ayat # Our sura 0 is db's sura 1

            rs.each do |row|
                f.write row.join "\s "
                f.puts(ayat_symbol_for(ayat) + "  ")
            end
        end
    end

rescue SQLite3::Exception => e
    puts "Exception Occurred"
    puts e

ensure
    stm.close if stm
    db.close if db
    f.close if f
end

