ServiceDiscovery::App.controllers :users do
  post '/' do
    {user_id: '123', new_user: true}.to_json
  end

  put ':user_id/address' do
    {id: 2}.to_json
  end

  get '/:user_id/address' do
    {
        addresses: [
            {
                id: 29,
                line1: "180, somebuilding",
                line2: "someotherroad",
                landmark: "nearthat",
                city: "moholla",
                state: "rajya",
                county: "desh",
                pincode: 1299468,
                name:"naam",
                phone_number:"9898989898"
            }]
    }.to_json
  end

  put '/:user_id/update_address' do
    {
        addresses: [
            {
                id: 29,
                line1: "180, somebuilding",
                line2: "someotherroad",
                landmark: "nearthat",
                city: "moholla",
                state: "rajya",
                county: "desh",
                pincode: 1299468,
                name:"naam",
                phone_number:"9898989898"
            }]
    }.to_json

  end
end
