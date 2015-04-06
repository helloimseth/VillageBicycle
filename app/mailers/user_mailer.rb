class UserMailer < ApplicationMailer
  default from: 'notifications@villagebicycle.com'

  def activation_email(user)
    @user = user
    @url = "http://village-bicycle.com/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Village Bicycle Account Activiation')
  end
end
