class User < ActiveRecord::Base
  include HistoricalValidate::Models::Validatable
  # devise :database_authenticatable, :validatable
  attr_accessor :password
end
