class WelcomeController < ApplicationController


  def index
  end

  def show
    # @messages = []

    # imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    # imap.authenticate('XOAUTH2', current_user.email, session[:token])
    # puts "IMAP signed in"
    # imap.select('INBOX')
    # puts "Inbox"
    # i = 0
    #   imap.search(["1:10"]).each do |message_id|

    #     msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
    #     mail = Mail.read_from_string msg
    #     mail_body = mail.multipart? ? mail.html_part : mail.body.decoded
    #     mail_body = Nokogiri::HTML(mail_body.to_s)
    #     email_hash = {  from: mail.from, 
    #                     to: mail.to, 
    #                     sent_at: mail.date.to_time.strftime('%a %b %d %Y %H:%M:%S %Z'),
    #                     subject: mail.subject.to_s.force_encoding('UTF-8'),
    #                     content: mail_body
    #                   }
    #     @messages << email_hash
    #     puts email_hash
    #     puts "#{i} ================================================================================="
    #     i += 1
    #   end

  end

  private


end