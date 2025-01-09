# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Welcome Message
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Navigation Links
    columns do
      column do
        panel "Quick Links" do
          ul do
            li link_to "Home", root_path, target: "_blank"
            li link_to "Logout", destroy_user_session_path, method: :delete
          end
        end
      end


    end

    # Example: Recent Records
    columns do
      column do
        panel "Recent Users" do
          ul do
            User.order(created_at: :desc).limit(5).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end
    end
  end
end
