class ContactMailer < ApplicationMailer

  def contact_user(user)
    @user = user
    mail to: @user.email, subject:"hello~"
  end

end
