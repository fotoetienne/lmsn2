class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  has_one :dj, :dependent => :destroy
  has_one :singer, :dependent => :destroy

  def name
    if role == "dj" and !dj.nil? and !dj.name.blank?
      dj.name
    elsif role == "singer" and !singer.nil? and !singer.name.blank?
      singer.name
    elsif role == "admin"
      email+" (Admin)"
    elsif role == "guest"
      "Guest"
    else
      email
    end
  end
  
  def account
    if role == "dj"
      dj
    elsif role == "singer"
      singer or nil
    else
      nil
    end
  end

  def admin?
    role == "admin" ? true : false
  end

  def dj?
    role == "dj" ? true : false
  end

  def singer?
    role == "singer" ? true : false
  end

end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#

