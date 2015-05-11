Spree::Admin::VariantsController.class_eval do

  def edit
    @variant.volume_price_models.build if !@variant.volume_price_models
    super
  end

end
