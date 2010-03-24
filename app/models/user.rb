class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
