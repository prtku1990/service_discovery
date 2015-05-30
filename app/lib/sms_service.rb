class SmsService
  #Use wisely. Each sms costs :)
  def self.send_sms(contact_number, message)
    base_url = "https://rest.nexmo.com/sms/json?api_key=e6ce19eb&api_secret=c6fe5a95&from=NEXMO"
    to_url = "&to=91#{contact_number}"
    text_url = "&text=#{message}"
    url = URI.encode(base_url + to_url + text_url)
    resource = RestClient::Resource.new url
    response = resource.get
    JSON.parse(response, symbolize_names: true)
  end
end