class Email < ActiveRecord::Base
  belongs_to :project

  def self.email_fetch(project, email, token)
    imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    imap.authenticate('XOAUTH2', email, token)
    gmail = {inbox: 'INBOX', sent: '[Gmail]/Sent Mail'}
    gmail.each do |name, mailbox|

      imap.examine(mailbox)
      status = imap.status(mailbox, ["MESSAGES"])
      imap.search(['501:1000']).each do |message_id|

        msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
        mail = Mail.read_from_string msg
        # mail_body = mail.multipart? ? mail.html_part[1] : mail.body.decoded
        from = mail.from ? mail.from.to_s : "From Placeholder"
        to = mail.to ? mail.to.to_s : "To Placeholder"
        # mail_body = Nokogiri::HTML(mail_body.to_s)
        email =  Email.create(from: from, 
                              to: to, 
                              sent_at: mail.date.to_time.strftime('%a %b %d %Y %H:%M:%S %Z'),
                              subject: mail.subject,#.to_s.force_encoding('UTF-8'),
                              # content: mail_body.to_s,
                              folder: name,
                              project_id: project 
                              )
        email.save

        puts message_id
      end
    end
  end


  def self.email_count(dates)

    x = Hash.new(0)
    dates.each do |z|
      x[z] +=1
    end
    return x
  end

  def self.sender_count(senders)

    x = Hash.new(0)
    senders.each do |z|
      x[z] +=1
    end
    y = x.reject{ |k,v| v < 5 }
  end

  def self.search_email argument
    Email.where("subject LIKE :query OR content LIKE :query", query: "%#{argument}%")
  end

  def self.search_email_date argument
    Email.where("sent_at LIKE :query", query: "%#{argument}")
  end
end
