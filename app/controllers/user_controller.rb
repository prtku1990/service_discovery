ServiceDiscovery::App.controllers :users do
  
  get :index, :map => '/foo/bar' do
    "hello"
  end

  # post "/" do
  #   params = get_create_user_params
  #   print params
  # end
  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
