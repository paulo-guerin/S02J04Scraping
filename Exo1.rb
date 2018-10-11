
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(url)
    page = Nokogiri::HTML(open(url))     
    a= page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    @mail_array.push(a.text)
end

def get_all_the_urls_of_val_doise_townhalls (adresse) 

    page = Nokogiri::HTML(open(adresse))   

    mairie_links = page.css("a.lientxt")
    
    array_of_names = []
    array_of_urls = []

    mairie_links.each do |infos|
        array_of_urls.push("http://annuaire-des-mairies.com"+ infos['href'][1..-1])
        array_of_names.push(infos.text)
        end

    @mail_array = []    
    
    array_of_urls.each do |url|
        get_the_email_of_a_townhal_from_its_webpage(url)
        end
    
    final_array = Hash[array_of_names.zip(@mail_array)]
    puts final_array

end

get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")


