ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel "Recent Games" do
          ul do
            Game.last(10).reverse.map do |game|
              li h4 link_to game.title, admin_game_path(game)
              if game.user.present?
                div b "☆#{game.user.nickname}☆"
                div "#{game.user.email}"
              else
                status_tag('Empty')
              end
              b small "#{game.created_at}"
            end
          end
        end
      end

      column do
        panel "Recent Users" do
          ul do
            User.last(15).reverse.map do |user|
              li h4 link_to(user.email, admin_user_path(user))
              b small "#{user.nickname} - "
              b small "#{user.created_at}"
            end
          end
        end
      end

      column do
        panel "Recent Rounds" do
          ul do
            Round.last(10).reverse.map do |round|
              li h4 link_to(round.kata_name, admin_round_path(round))
              div b small "Participations: #{round.participations.count}"
              b small "#{round.created_at}"
            end
          end
        end
      end

      column do
        panel "Recent Participations" do
          ul do
            Participation.last(10).reverse.map do |partic|
              li h4 link_to "Participation id: #{partic.id}",
                      admin_participation_path(partic)
              div b "User: #{partic.user.nickname} - #{partic.user.email}"
              div b "Round: #{partic.round.kata_name}"
              div b small "#{partic.created_at}"
              div b small "ACTIVE: #{partic.active}"
              div b small "DONE: #{partic.done}"
            end
          end
        end
      end

      # column do
      #   panel "Info" do
      #     para "Welcome to the Jungle."
      #   end
      # end

    end
  end # content
end
