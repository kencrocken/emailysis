class WelcomeMailer < ActionMailer::Base
    default to: "kcrocken@gmail.com"

    def contact_email(message)
        @name = message[:name]
        @email = message[:email]
        @body = message[:comments]

        mail(from: "no-reply@emailysis.com", subject: 'Contact Request')
    end
end