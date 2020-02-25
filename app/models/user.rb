class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :daily_calories
  has_many :meals

  enum status: {default_user: 0, manager: 1, admin: 2}

  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
