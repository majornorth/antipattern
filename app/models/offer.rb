class Offer < ActiveRecord::Base
  include AASM
  validates_presence_of :review_request_id, :user_id
  belongs_to :review_request
  belongs_to :user

  aasm do
    state :presented, :initial => true, :before_enter => :notify_of_offer
    state :accepted
    state :rejected
    state :delivered
    state :disputed
    state :paid

    event :accept do
      before do
        notify_acceptance
      end
      transitions from: :presented, to: :accepted
    end

    event :reject do
      before do 
        notify_rejection
      end
      transitions from: :presented, to: :rejected
    end

    event :deliver do
      before do 
        notify_delivery
      end
      transitions from: :accepted, to: :delivered
    end

    event :pay do
      before do 
        notify_paid
      end
      transitions from: :delivered, to: :paid
    end

    event :dispute do
      before do 
        notify_dispute
      end
      transitions from: :delivered, to: :disputed
    end
  end

  def recipients
    offer_owner = user
    review_request_owner = review_request.user
    code_review = review_request
    {offer_owner: offer_owner, review_request_owner: review_request_owner, code_review: code_review, offer: self}
  end

  def notify_delivery
    OfferMailer.notify_delivery(recipients).deliver
  end

  def notify_dispute
    OfferMailer.notify_dispute(recipients).deliver
  end

  def notify_paid
    OfferMailer.notify_pay(recipients).deliver
  end

  def notify_acceptance
    OfferMailer.notify_acceptance(recipients).deliver
  end

  def notify_rejection
    OfferMailer.notify_rejection(recipients).deliver
  end

  def notify_of_offer
    OfferMailer.notify_of_offer(recipients).deliver
  end

  def set_state! new_state
    return self.accept! if new_state == 'accept'
    return self.reject! if new_state == 'reject'
    return self.deliver! if new_state == 'deliver'
    return self.pay! if new_state == 'pay'
    return self.dispute! if new_state == 'dispute'
  end

end
