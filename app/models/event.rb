class Event < ApplicationRecord
    belongs_to :user
    belongs_to :contact
    has_many :messages
    has_many :gifts

    # after_create :reminder
    validates :date, :time, :event_name, :category, :message, presence: :true
#require api key file 
#   Notify our appointment attendee X minutes before the appointment time

  def reminder
    # byebug
    puts "hello"
    # @twilio_number = ENV['TWILIO_NUMBER']
    # account_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_number = '+12672144969' 
    account_sid = 'ACb964b111bb91a4ac4ba8457804d27729'
    # @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new account_sid, '85e3b75cb0df6ed836ee43ef69aee2db'
    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    body = "Hi #{self.contact.name}, #{self.message}" 
   
    message = @client.messages.create(
      :from => @twilio_number,
      :to => self.contact.contact_info,
      #make sure phone number should be string 
      :body => body,
      
    )
  end

  # def when_to_run
  #   minutes_before_appointment = 2.minutes
  #   time - minutes_before_appointment
  # end

  # handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }
  # puts "Text was scheduled"
end


# ----put this in terminal ---> rails g delayed_job:active_record

