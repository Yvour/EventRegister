class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_type
  has_many :event_dates
  
  validates_presence_of :user, :event_type, :initial_date, :name
  def to_label
    "#{name}"
  end
  

end
