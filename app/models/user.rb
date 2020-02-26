class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :daily_calories
  has_many :meals, dependent: :destroy

  enum status: {default_user: 0, manager: 1, admin: 2}

  def first_name
    return self.name.split.first if self.name
    "Anonymous"
  end

  def last_name
    return self.name.split.last if self.name
    ""
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
