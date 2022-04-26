class EmployeeMailer < ApplicationMailer

	def fun_friday
    @blind_date = params[:blind_date]
    return unless @blind_date

    recipients = ['parekhviral1632@gmail.com']#Employee.where(id: @blind_date.groups).pluck(:email)
    subject = "Fun Friyaay"

    mail(bcc: recipients, subject: subject)
	end
end
