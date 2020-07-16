class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about, :contact]

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

  def artificial_batch
    unless current_user.id == 2
      flash[:danger] = "---"
      redirect_back(fallback_location: root_path)
    else
      current_user.hyles.each do |hyle|
        hyle.update(birthday_left: hyle.days_before(Date.current)) unless hyle.birthday.nil?
        hyle.set_relationship
      end
      current_user.set_relationship_percentage
      flash[:success] = "シークレット操作によりバッチ処理が完了しました"
      redirect_back(fallback_location: root_path)
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def after_sign_in_path_for(resource)
      users_path
    end

    def prohabit_demo_user
      if current_user.id == 2
        flash[:success] = "デモユーザーでは登録、編集、削除はできません"
        redirect_back(fallback_location: users_path)
      end
    end
end
