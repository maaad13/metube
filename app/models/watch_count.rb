class WatchCount < ApplicationRecord
  belongs_to :video, dependent: :destroy


  validates :ip_address,presence: true 
end
