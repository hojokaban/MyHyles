module ApplicationHelper
    def set_error_flash(resource)
        error_title = I18n.t("errors.messages.not_saved",
                   count: resource.errors.count,
                   resource: resource.class.model_name.human.downcase)
        error_message = "<h2>#{error_title}</h2><ul>"
        resource.errors.full_messages.each { |message| error_message += "<li>" + message + "</li>" }
        return error_message + "</ul>"
    end
end
