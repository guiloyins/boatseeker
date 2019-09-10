# frozen_string_literal: true

class Boat < ApplicationRecord
  validates :model, :length, :lonlat, presence: true
  validates :length, numericality: { greater_than: 0 }
  before_validation :set_location

  scope :within, lambda { |latitude, longitude, distance = 1|
    where(format(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    }, longitude, latitude, distance))
  }

  attr_accessor :latitude, :longitude

  def set_location
    self[:lonlat] = "POINT(#{longitude} #{latitude})"
  end

  def self.ransackable_scopes(auth_object = nil)
      %i(within)
  end
end
