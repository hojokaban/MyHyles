class User < ApplicationRecord

    has_many :categories, dependent: :destroy
    has_many :hyles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

    validates :name, presence: true, length: {maximum: 20}
    validates :notice_before, presence: true, numericality: { less_than: 366,
                greater_than_or_equal_to: 0 }
    validates :term, presence: true, numericality: { less_than: 121,
                greater_than: 0}
    acts_as_taggable
    attr_accessor :tag

    def update_without_current_password(params)
        current_password = params.delete(:current_password)
        if params[:password].blank? && params[:password_confirmation].blank? && params[:tag].blank?
            params.delete(:password)
            params.delete(:password_confirmation)
            result = update_attributes(params)
        else
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
