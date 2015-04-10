Spree::ProductsController.class_eval do
  before_action :load_pricing_model, only: :show

  private
    def load_pricing_model
      user = try_spree_current_user

      if user
        role = try_spree_current_user.resolve_role
      else
        role = Spree::Role.find_by name: 'user'
      end

      @volume_prices = @product.master.volume_prices(role)
    end

end