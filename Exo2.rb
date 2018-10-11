require 'rubygems'
require 'nokogiri'
require 'open-uri'


def bitcoin(url)
    page = Nokogiri::HTML(open(url))  

    crypto_name = []
    path_crypto = page.css("a.currency-name-container.link-secondary")
    path_crypto.each do |section|
        crypto_name << section.text
        end

    crypto_value = []
    path_value= page.css("a.price")
    path_value.each do |section|
        crypto_value << section.text
        end

    array_of_hash = []
    compteur = 0
    while compteur <= crypto_name.length
        hash_temporaire = {"#{crypto_name[compteur]}"=> crypto_value[compteur]}
        array_of_hash << hash_temporaire
        compteur = compteur + 1
        end

    print array_of_hash
    puts
end

loop do
    bitcoin("https://coinmarketcap.com/all/views/all/")
    puts "1h avant la prochaine maj"
    sleep(3600)
end