class Contact < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  has_many :phones

  scope :search_and_order_by_last_name,
    ->(last_name) { where('last_name LIKE ?', "#{last_name}%").order(:last_name) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
