class Spree::Admin::CorreiosSettingsController < Spree::Admin::BaseController

  def show
    @preferences = ['origin_zip_code', 'id_correios', 'services']
  end

  def edit
    @preferences = [:origin_zip_code, :id_correios, :password_correios, :services]
  end

  def update
    params.each do |name, value|
      next unless Spree::CorreiosShipping::Config.has_preference? name
      Spree::CorreiosShipping::Config[name] = value
    end

    redirect_to admin_correios_settings_path
  end

end
