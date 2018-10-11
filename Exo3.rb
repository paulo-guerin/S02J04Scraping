
require 'rubygems'
require 'nokogiri'
require 'open-uri'
   


def get_the_email_of_deputy(url)
    page = Nokogiri::HTML(open(url))   
    array_temporaire = []
    selection = page.css("a.email")
    selection.each do |v|
        return v["href"][7..-1]
    end
end

def infos_deputy (website)
    page = Nokogiri::HTML(open(website))   

    deputy_names = []
    array_of_urls = []

    deputy_links = page.css("div#deputes-list div.clearfix.col-container ul.col3 li a")

    deputy_links.each do |link|
        deputy_names << (link.text)
        array_of_urls << "http://www2.assemblee-nationale.fr"+link['href']
    end
    
    deputy_names_split = []
    deputy_names.each do |names|
        deputy_names_split << names.split[1..-1].join(" ")
    end
    puts deputy_names_split

    array_of_mails = []
    array_of_urls.each do |url|
        array_of_mails << get_the_email_of_deputy(url)
        puts array_of_mails
    end
    puts array_of_mails

    array_final = []
    compteur = 0
    while compteur<array_of_mails.length
        hash_temporaire = {"#{deputy_names_split[compteur]}"=> array_of_mails[compteur]}
        array_final << hash_temporaire
        compteur = compteur + 1
        puts array_final
    end
    puts array_final
    
end


infos_deputy ("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

