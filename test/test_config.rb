RACK_ENV = 'test' unless defined?(RACK_ENV)
require "test/unit"
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.expand_path(File.dirname(__FILE__) + "/factories")
require 'mocha'
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

require 'active_record/fixtures'


class ActiveSupport::TestCase
  include Mocha::API
  include Rack::Test::Methods
  include ActiveRecord::TestFixtures
  include FactoryGirl::Syntax::Methods

  # You can use this method to custom specify a Rack app
  # you want rack-test to invoke:
  #
  #   app ServiceDiscovery::App
  #   app ServiceDiscovery::App.tap { |a| }
  #   app(ServiceDiscovery::App) do
  #     set :foo, :bar
  #   end
  #

  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end
end

