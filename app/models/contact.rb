class Contact < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :first_name, format: {with: /\A[a-zA-Z]+\z/}
  validates :email, uniqueness: true

  has_many :phones

  scope :search_and_order_by_last_name,
    ->(last_name) { where('last_name LIKE ?', "#{last_name}%").order(:last_name) }

  scope :active, -> { where(blocked: false) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
