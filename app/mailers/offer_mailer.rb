class OfferMailer < ActionMailer::Base
  SUBJ = 'Antipattern.io offer for code review'
  def notify_of_offer args
    @offer_owner = args[:offer_owner]
    @review_request_owner = args[:review_request_owner]
    to = @review_request_owner.email
    cc = @offer_owner.email
    mail to: to, from: 'jd@startuplandia.io', cc: cc, subject: SUBJ
  end
end