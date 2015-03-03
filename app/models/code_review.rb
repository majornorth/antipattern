class CodeReview < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :detail, :user_id, :title
  has_many :offers
  after_create :notify_new_code_review

  scope :all_active, -> {where(deleted: false)}

  def has_offers?
    ! offers.empty?
  end

  def notify_new_code_review 
    NotificationChannel.send! name: 'new_code_review', code_review: self
  end
end
