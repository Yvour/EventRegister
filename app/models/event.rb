class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_type
  has_many :event_dates
  
  validates_presence_of :user, :event_type, :initial_date, :name
  validates_inclusion_of :event_date_day, :in => 0..31
    
  def to_label
    "#{name}"
  end
  
  def generate_dates(controldate = Date.today)
    event = Event.find(self.id)
    event_type_name = self.event_type.name;
    event_date_day = event.event_date_day;
    last_date = self.last_date
    new_last_date = last_date
    if event_type_name != 'once'
      while new_last_date < controldate

    case event_type_name
    when 'weekly'
      begin
        new_last_date = event.last_date + 7
        event.event_dates << EventDate.new(date: new_last_date )
      end
    when 'dayly'  
      begin   
        new_last_date = event.last_date + 1
        event.event_dates << EventDate.new(date: new_last_date) 
      end

    when 'monthly' #      Если задан день месяца, нужно опорная дата, начало года
      begin
       rootdate = Date.today
      if event.event_date_day.to_i > 0
        rootdate = new_last_date.beginning_of_year.days_since(event_date_day-1);
      else
        rootdate = new_last_date.beginning_of_year.days_since(new_last_date.day-1);
      end
        new_last_date = rootdate.months_since(new_last_date.month)
        event.event_dates << EventDate.new(date: new_last_date)
      end
      
    when 'yearly' #      Если задан день месяца, нужно опорная дата, начало года
      begin
       rootdate = Date.today
      if event.event_date_day.to_i > 0
        rootdate = new_last_date.beginning_of_year.days_since(event_date_day-1);
      else
        rootdate = new_last_date.beginning_of_year.days_since(new_last_date.day-1);
      end
        new_last_date = rootdate.months_since(new_last_date.month+11)
        event.event_dates << EventDate.new(date: new_last_date)
      end      
      
    end
    end
      event.save
    end
  end


end
