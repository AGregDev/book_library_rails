class UserMailer < ApplicationMailer
  default from: "gregory.albert@spoonconsulting.com"

  def return_reminder(email, book)
    @email = email
    @book = book
    @due_date = @book.borrowered_at + 2.weeks
    mail(to: email, subject: "Reminder: Return Your Book")
  end
end
