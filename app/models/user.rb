class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events     
  
  def to_label
   # name == '' ? "#{email}" : "#{name}"
   "#{email}"
  end    
  
  def the_name
    n = self.name
    if self.name.strip == ''
      n = email
    end
    n
  end
end
