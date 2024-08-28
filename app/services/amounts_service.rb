class AmountsService
  attr_reader :token, :value
  def initialize(token: nil, value: nil)
    @token = token
    @value = value
  end

  def perform(storage_service = StorageService)
    if token.present? && value.present? && !Amount.exists?(token: token)
      Amount.create(token: token, value: value)
      storage_service.new(value: value).increment_total_amount
    end

    Storage.total_amount.value || 0
  end
end
