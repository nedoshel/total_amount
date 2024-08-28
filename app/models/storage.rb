class Storage < ApplicationRecord
  def self.total_amount
    find_or_initialize_by(name: :total_amount)
  end
end
