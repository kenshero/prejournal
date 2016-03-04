class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :username
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 4..40},
                       :on => :create
  validates :password, :confirmation => true,
                       :length => {:within => 4..40},
                       :allow_blank => true,
                       :on => :update
end
