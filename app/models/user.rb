class User < AWS::Record::Model
  
  string_attr :email
  string_attr :encrypted_password

  string_attr :reset_password_token
  datetime_attr :reset_password_sent_at

  datetime_attr :remember_created_at
  
  integer_attr :sign_in_count
  datetime_attr :current_sign_in_at
  datetime_attr :last_sign_in_at
  string_attr :current_sign_in_ip
  string_attr :last_sign_in_ip
  
  # string_attr :confirmation_token
  # datetime_attr :confirmed_at
  # datetime_attr :confirmation_sent_at
  # string_attr :uncomfirmed_email
  
  # integer_attr :failed_attempts, :default => 0
  # string_attr :unlock_token
  # datetime_attr :locked_at
  
  # strig_attr :authentication_token
  
  timestamps
  
  # validations needed by devise
#  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  
  # little hack for devise
#  def self.validates_uniqueness_of(arg1,arg2)
#  end
  
  # include devise model methods
  extend Devise::Models
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeouttable, :omniauthable
  # :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :trackable,
         :validatable
  
  # # Include default devise modules. Others available are:
  # # :token_authenticatable, :confirmable,
  # # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
# 
  # # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # # attr_accessible :title, :body
end
