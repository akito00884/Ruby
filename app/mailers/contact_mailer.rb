# coding: utf-8

class ContactMailer < ActionMailer::Base
  default from: "【送信元メールアドレス】" 
  def sent(contact)
    @contact = contact
    mail(:to => "【送信先メールアドレス】", :from => @contact.email, :subject => 'フォームからのお問い合わせ')
  end
end