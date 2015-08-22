class EventDate < ActiveRecord::Base
  belongs_to :event
  
  validates_presence_of :event, :date
  
  
  
  before_validation :set_event_last_date


    def set_event_last_date
      the_event = Event.find(self.event_id)
      if self.date > the_event.last_date
        event.update(last_date: self.date)
      end

      
    end
end
