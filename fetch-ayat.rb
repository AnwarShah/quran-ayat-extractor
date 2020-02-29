require 'json'
require 'sqlite3'
require_relative './no-to-ayat-symbol.rb'
require_relative './sura_name_translator.rb'

begin 
    db = SQLite3::Database.open "quran_indo.db"
    $stm = db.prepare "SELECT Text FROM VERSES WHERE sura = :sura AND ayah = :ayah"
    $f = File.open("ayat.txt", 'w:UTF-8')
rescue SQLite3::Exception => e
    puts "Exception Occurred"
    puts e
end

def write_ayat(sura_idx, ayat_no)
    rs = $stm.execute key_to_no(sura_idx)+1, ayat_no # Our sura 0 is db's sura 1

    rs.each do |row|
        $f.write row.join "\s "
        $f.print(ayat_symbol_for(ayat_no) + "  ")
    end
end

begin
    sura_ayat = JSON.parse(File.open('ayat_no.json', 'r').read)

    sura_ayat.each do |sura, ayats_str|
        puts "Surah #{sura}, Ayats: #{ayats_str}"

        $f.puts key_to_sura_name(sura)
        # split on "," and remove any whitespace
        ayats_arr = ayats_str.split(",").map { |s| s.delete(" ") }

        # the ayats_arr could containe single ayat no like "3" or a range like "1-4"
        ayats_arr.each do |ayat_no_str|
            # if a range i.e. "1-4"
            if ayat_no_str.include?("-")
                # expand to array
                low_hi = ayat_no_str.split('-').map(&:to_i) # "1-4" => [1, 4]
                ayats = low_hi[0].upto(low_hi[1]).to_a # [1,2,3,4]
                ayats.each do |ayat|
                    write_ayat(sura, ayat)
                end
            else
            # if a single ayat  
                ayat = ayat_no_str.to_i
                write_ayat(sura, ayat)
            end
            $f.puts("\n\n")
        end
    end

rescue SQLite3::Exception => e
    puts "Exception Occurred"
    puts e

ensure
    $stm.close if $stm
    $db.close if $db
    $f.close if $f
end

