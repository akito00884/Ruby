class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :content
end