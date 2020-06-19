module ApplicationHelper
    def set_error_flash(resource)
        error_title = I18n.t("errors.messages.not_saved",
                   count: resource.errors.count,
                   resource: resource.class.model_name.human.downcase)
        error_message = "<h3>#{error_title}</h3><ul>"
        resource.errors.full_messages.each { |message| error_message += "<li>" + message + "</li>" }
        return error_message + "</ul>"
    end
    def today_date
      today = Date.current
      today_date = today.to_s[5..6] + today.to_s[8..10]
      return today_date
    end
    def month_later_date(today_date)
      month_later_date = (today_date.to_i + 100).to_s
      month_later_date.insert(0, "0") if month_later_date.length == 3
      month_later_date = month_later_date.slice(2..3).insert(0, "01") if month_later_date.slice(0..1) == "13"
      return month_later_date
    end
end
