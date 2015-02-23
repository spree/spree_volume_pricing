Spree::Admin::VariantsController.class_eval do

  def edit
    @variant.volume_price_models.build if !@variant.volume_price_models
    super
  end

  def volume_price_models
    @product = @variant.product
    @volume_price_models = Spree::VolumePriceModel.all
    @variant.volume_price_models.build if @variant.volume_price_models.empty?
  end

  private

  # this loads the variant for the master variant volume price editing
  def load_resource_instance
    parent

    if new_actions.include?(params[:action].to_sym)
      build_resource
    elsif params[:id]
      Spree::Variant.find(params[:id])
    end
  end

  def location_after_save
    if @product.master.id == @variant.id and params[:variant].has_key? :volume_prices_attributes
      return volume_prices_admin_product_variant_url(@product, @variant)
    end
    super
  end
end
