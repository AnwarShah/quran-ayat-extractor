# quran-ayat-extractor
Extract Quran ayat from sqlite db in Indo-Pak format

## Requirements
You should have following softwares available in your environment. 
- ruby interpreter ([How to][2])
- [`sqlite3`][3] rubygem

## Using
Download the zip archive or clone the repository. Browse to the root of the repo from a terminal. Modify `ayat_no.json` file to suit your need. Check `sura_name_translator.rb` for defined sura name to use in the json file. 
For example, you should use `baqara` instead of `baqarah` as key. Once you've done with customizing, execute following command to generate 
`ayat.txt` with desired surah and ayat. 

    ruby fetch-ayat.rb
    
Then open the `ayat.txt` file with a word processor and customize formatting to your need. Save as odt or ms office format or Generate PDF.

## Acknowledgement

I've use the database from Greentech's [Al Quran][1] application. 

[1]:https://greentechapps.com/apps/quran/
[2]:https://www.ruby-lang.org/en/documentation/installation/
[3]:https://rubygems.org/gems/sqlite3/
