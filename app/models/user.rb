class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable
  has_many :projects, :dependent => :destroy

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first

      if user
        return user
      else
        registered_user = User.where(:email => access_token.info.email).first
        if registered_user
          return registered_user
        else
          user = User.create( name: data["name"],
                              email: data["email"],            
                              password: Devise.friendly_token[0,20],
                              image: data["image"],
                              provider:access_token.provider,
                              uid: access_token.uid,
                              token: access_token.credentials.token
                            )
        end
     end
  end

end
