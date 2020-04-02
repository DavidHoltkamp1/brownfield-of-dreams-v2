# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@activation.io'
  layout 'mailer'
end
