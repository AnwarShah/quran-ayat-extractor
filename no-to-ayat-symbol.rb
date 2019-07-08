# insert arabic ayat stop no using unicode
RT_BR = "\ufd3e"
LT_BR = "\ufd3f"

NO_TO_SYMBOL = {
    "0" => "\u06f0",
    "1" => "\u06f1",
    "2" => "\u06f2",
    "3" => "\u06f3",
    "4" => "\u06f4",
    "5" => "\u06f5",
    "6" => "\u06f6",
    "7" => "\u06f7",
    "8" => "\u06f8",
    "9" => "\u06f9"
}

def ayat_symbol_for(ayat_no)
    digits = ayat_no.to_s.split('')
    LT_BR + digits.inject("") { |res, n| res += NO_TO_SYMBOL[n] } + RT_BR
end
