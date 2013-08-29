class CrowdfundingPoll < ActionMailer::Base
  layout 'email'
  def notify(user)
    @user = user
    address = Mail::Address.new(::Configuration[:email_contact])
    address.display_name = ::Configuration[:company_name]
    subject = "Vamos juntos retratar o financiamento coletivo no Brasil?"
    mail({
      from: address.format,
      to: @user.email,
      subject: subject
    }).deliver
  end
end
