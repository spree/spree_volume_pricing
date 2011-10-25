LineItem.class_eval do
  after_create :check_volume_pricing
  before_update :check_volume_pricing
  
  private
  def check_volume_pricing
    if changed? && changes.keys.include?("quantity")
      self.price = variant.volume_price(quantity)
    end
  end
end
