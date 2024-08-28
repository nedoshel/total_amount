class StorageService
  attr_reader :value

  def initialize(value: nil)
    @value = value
  end

  def increment_total_amount
    LockService.with_lock do
      total_amount = Storage.total_amount
      total_amount.value ||= 0
      total_amount.update(value: total_amount.value + value.to_i) if value.present?
    end
  end
end
