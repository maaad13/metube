class Video < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :watch_counts, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: :true 
  validates :file, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def increment_watch_count(ip_address)
    unless watch_counts.exists?(ip_address: ip_address)
      increment!(:watch_counts)
      watch_counts.create(ip_address: ip_address)
    end
  end
end
