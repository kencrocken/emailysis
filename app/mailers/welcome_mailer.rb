class WelcomeMailer < ActionMailer::Base
    default to: ENV["GMAIL_USERNAME"]

    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body

        mail(from: email, subject: 'Contact Request')
    end
end