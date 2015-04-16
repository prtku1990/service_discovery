ServiceDiscovery::App.controllers :services do
  get '/:service_id/slots', :provides => :json do
    service = Service.find(params[:service_id])
    slots = service.get_slots(params['date'])
    time_slots = slots.collect{|slot| slot.to_s(:time)}
    {slots: time_slots}.to_json
  end
end