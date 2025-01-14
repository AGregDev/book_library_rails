namespace :batch do
  desc "Send mails to users"
  task send_messages: :environment do
    Book.all.each do |book|
      UserMailer.return_reminder(book.get_email, book).deliver_now if book.overdue?

      puts "PROCESSING BOOKS AND SENDING MAILS"
    end
  end
end
