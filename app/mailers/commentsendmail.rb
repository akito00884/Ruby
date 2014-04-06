# coding: utf-8

class Commentsendmail < ActionMailer::Base
  default from: "【送信元メールアドレス】" 

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.sendmail.subject
  #

  def sendmail(comment)
    @comment = comment

    mail(:to => "【送信先メールアドレス】",
   :subject => 'コメントが追加されました')
  end
end