class Spree::Admin::CorreiosSettingsController < Spree::Admin::BaseController

  def show
    @preferences = ['origin_zip_code', 'id_correios', 'services']
  end

  def edit
    @preferences = [:origin_zip_code, :id_correios, :password_correios, :services]
  end

end
