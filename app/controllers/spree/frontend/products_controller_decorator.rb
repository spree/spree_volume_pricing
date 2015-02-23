Spree::ProductsController.class_eval do
  before_action :load_pricing_model, only: :show

  private
    def load_pricing_model
      @volume_prices = @product.master.volume_prices
    end

end