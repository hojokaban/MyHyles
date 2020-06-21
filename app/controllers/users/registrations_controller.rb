# frozen_string_literal: true
include ApplicationHelper
class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :set_category, only: [:edit, :update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    flash[:danger] = set_error_flash(resource) if resource.errors.any?
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(current_user.to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    unless resource.term == params[:user][:term]
      resource.hyles.each{ |hyle| hyle.set_relationship(params[:user][:term]) }
      resource.set_relationship_percentage
    end
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      respond_with resource, location: after_update_path_for(resource)
    else
      flash[:danger] = set_error_flash(resource) if resource.errors.any?
      respond_with resource, location: after_update_path_for(resource)
    end
  end

  def update_tag
      message = current_user.add_tag(params[:user][:tag])
      message.class == String ? flash[:danger] = message : flash[:success] = "タグが追加されました!"
      redirect_back(fallback_location: root_path)
  end

  # DELETE /resource
  def destroy
      current_user.tag_list.remove(params[:format])
      current_user.update(tag_list: current_user.tag_list)
      flash[:success] = "タグを削除しました"
      redirect_back(fallback_location: root_path)
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update,
         keys: [:name, :birthday, :notice_before, :term, :require_notice, :tag])
    end

    def update_resource(resource, params)
        resource.update_without_current_password(params)
    end

    def after_update_path_for(resource)
        edit_user_registration_path
    end

    def set_category
        @category = Category.new
        @categories = current_user.categories
    end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
