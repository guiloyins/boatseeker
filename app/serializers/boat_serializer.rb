class BoatSerializer < ActiveModel::Serializer
  attributes :id, :model, :length, :latitude, :longitude, :created_at, :updated_at

  def longitude
    self.object.lonlat.longitude
  end

  def latitude
    self.object.lonlat.latitude
  end
end