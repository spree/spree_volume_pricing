Spree::ProductsController.class_eval do
  before_action :load_pricing_model, only: :show

  private
    def load_pricing_model
      user = try_spree_current_user
      @volume_prices = @product.master.volume_prices(user)
    end

end