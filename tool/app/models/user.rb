class User < ActiveRecord::Base
  has_many :entries
  has_many :projects , :through => :entries
end
