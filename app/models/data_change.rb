class DataChange < ApplicationRecord
  validates_presence_of :name, :data
end
