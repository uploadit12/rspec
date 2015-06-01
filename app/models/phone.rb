class Phone < ActiveRecord::Base

  validates :phone, uniqueness: { scope: :contact_id }

  belongs_to :contact


end
