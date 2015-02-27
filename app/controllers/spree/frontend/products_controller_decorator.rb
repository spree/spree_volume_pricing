Spree::ProductsController.class_eval do
  before_action :load_pricing_model, only: :show

  private
    def load_pricing_model
      role = try_spree_current_user.resolve_role
      @volume_prices = @product.master.volume_prices(role)
    end

end