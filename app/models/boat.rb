# frozen_string_literal: true

class Boat < ApplicationRecord
  validates :model, :length, :lonlat, presence: true
  validates :length, numericality: { greater_than: 0 }
  before_validation :set_location

  attr_accessor :latitude, :longitude

  def set_location
    self[:lonlat] = "POINT(#{latitude} #{longitude})"
  end
end
