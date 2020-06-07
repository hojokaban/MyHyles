class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

    validates :name, presence: true, length: {maximum: 20}

    def set_error_flash
        error_title = I18n.t("errors.messages.not_saved",
                   count: self.errors.count,
                   resource: self.class.model_name.human.downcase)
        error_message = "<h2>#{error_title}</h2><ul>"
        self.errors.full_messages.each do |message|
          error_message += "<li>" + message + "</li>"
        end
        return error_message + "</ul>"
    end
end
