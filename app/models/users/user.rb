class User < ActiveRecord::Base
  has_many :addresses

  def self.create_user(params)
    user = nil
    ActiveRecord::Base.transaction do
      user = User.create!(params.slice(:email_id, :password, :gender, :login_type))
      Address.create_address(params[:address], user.id) if params[:address]
    end
    user
  end
end
