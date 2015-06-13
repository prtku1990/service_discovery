# require 'googlevoiceapi'

ServiceDiscovery::App.controllers :services do
  get '/:service_id/slots', :provides => :json do
    service = Service.find(params[:service_id])
    slots = service.get_slots(params['date'])
    time_slots = slots.collect{|slot| slot.to_s(:time)}
    {slots: time_slots}.to_json
  end

#   get '/' do
#     api = GoogleVoice::Api.new('t.v.santhoshkumar@gmail.com', 'VISHNUROHINI')
#     api.sms('9538255159', 'This is my text message')
#   end
  get '/', :provides => :json do
    Service.all.to_json(except: [:id, :created_at, :updated_at, :description])
  end

  # get '/services/:service_id/start_times' do
  #   (0..6).collect do |day|
  #     time = Time.now + day.days
  #     {
  #         date: time.strftime('%F'),
  #         day: time.strftime('%a'),
  #         min_start_time: "08:00:00",
  #         max_start_time: "18:00:00"
  #     }
  #   end.to_json
  # end
end