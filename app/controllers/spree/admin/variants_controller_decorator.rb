Spree::Admin::VariantsController.class_eval do
  before_filter :setup_new_volume_price, :only => [:edit, :volume_prices]

  def volume_prices
    @product = @variant.product
  end

  def update_volume_price_positions
    params[:positions].each do |id, index|
      Spree::VolumePrice.find(id).update_attributes(:position => index)
    end

    respond_to do |format|
      format.html { redirect_to spree.admin_product_volume_prices_path(@variant) }
      format.js { render :text => 'Ok' }
    end
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

  def setup_new_volume_price
    @variant.volume_prices.build if @variant.volume_prices.empty?
  end
end
