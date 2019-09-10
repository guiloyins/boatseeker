# frozen_string_literal: true

class Boat < ApplicationRecord
  validates :model, :length, :lonlat, presence: true
  validates :length, numericality: { greater_than: 0 }
end
