class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

    validates :name, presence: true, length: {maximum: 20}
    validates :notice_before, numericality: { less_than: 366,
         greater_than_or_equal_to: 0, only_integer: true }
    validates :term, numericality: { less_than: 121,
         greater_than: 0, only_integer: true }

    def set_error_flash
        error_title = I18n.t("errors.messages.not_saved",
                   count: self.errors.count,
                   resource: self.class.model_name.human.downcase)
        error_message = "<h2>#{error_title}</h2><ul>"
        self.errors.full_messages.each { |message| error_message += "<li>" + message + "</li>" }
        return error_message + "</ul>"
    end

    def update_without_current_password(params)
        if params[:password].blank? && params[:password_confirmation].blank?
            params.delete(:current_password)
            params.delete(:password)
            params.delete(:password_confirmation)
            result = update_attributes(params)
        else
            current_password = params.delete(:current_password)
            if params[:password].blank?
              params.delete(:password)
              params.delete(:password_confirmation) if params[:password_confirmation].blank?
            end
            result = if valid_password?(current_password)
                      update(params)
                    else
                      assign_attributes(params)
                      valid?
                      errors.add(:current_password, current_password.blank? ? :blank : :invalid)
                      false
                    end
        end
        clean_up_passwords
        result
    end
end
