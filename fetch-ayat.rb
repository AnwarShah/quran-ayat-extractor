# ADD surah index. Name to number and number to ayat hash
require 'sqlite3'
require_relative './no-to-ayat-symbol.rb'
require_relative './no-to-sura-name.rb'

begin
    db = SQLite3::Database.open "quran_indo.db"
    f = File.open("ayat.txt", 'w:UTF-8')

    sura_ayat = {
        2 => [72,85,149,150,191,243],
        3 => [27],
        4 => [75],
        5 => [22,23,24,25],
        6 => [93,95],
        7 => [13, 18, 25, 58, 82],
        9 => [57, 64],
        10 => [31],
        14 => [13],
        15 => [34],
        16 => [69,78],
        20 => [55],
        22 => [22],
        23 => [35, 106,107],
        24 => [53],
        26 => [57, 167],
        27 => [37,67],
        28 => [20,21],
        30 => [19,25],
        35 => [37],
        36 => [33],
        34 => [2],
        40 => [11],
        43 => [11],
        47 => [13,29],
        48 => [22],
        50 => [42],
        51 => [35],
        54 => [7, 54],
        55 => [22],
        59 => [2],
        63 => [8],
        65 => [2],
        70 => [43],
        71 => [18],
        84 => [1,2,3,4,5],
        86 => [7],
        99 => [2]
    }

    stm = db.prepare "SELECT Text FROM VERSES WHERE sura = :sura AND ayah = :ayah"

    sura_ayat.each do |sura, ayats|
        f.puts no_to_sura_name(sura-1)
        ayats.each do |ayat|
            rs = stm.execute sura, ayat

            rs.each do |row|
                f.write row.join "\s"
                f.puts(ayat_symbol_for(ayat))
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

