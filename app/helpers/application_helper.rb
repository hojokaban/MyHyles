module ApplicationHelper
    def set_error_flash(resource)
        error_title = I18n.t("errors.messages.not_saved",
                   count: resource.errors.count,
                   resource: resource.class.model_name.human.downcase)
        error_message = "<h3>#{error_title}</h3><ul>"
        resource.errors.full_messages.each { |message| error_message += "<li>" + message + "</li>" }
        return error_message + "</ul>"
    end
    def today_date(today)
      today_date = today.to_s[5..6] + today.to_s[8..10]
      return today_date
    end
    def days_later_date(today, notice_before)
      days_later = today + notice_before
      return days_later.to_s[5..6] + days_later.to_s[8..10]
    end
end
