ActiveAdmin.register Round do

  # Strong PARAMS
  permit_params :kata_id, :duration, :notes, :active, :winners, :game_id, :json_response

  # INDEX page
  index do
    selectable_column
    column :id

    column :kata_name do |round|
      if round.kata_id.present?
        link_to "#{round.kata_name}",
           admin_round_path(round)
      else
        status_tag('Empty')
      end
    end

    column :duration

    column :winners do |round|
      round.winners.each do |winner_id|
        winner = User.find(winner_id)
        if winner.nickname.present?
          div b small link_to "#{winner.nickname}",
                 admin_user_path(round.id, winner)
        else
          div b small link_to "#{winner.email}",
                 admin_user_path(round.id, winner)
          # li em "no nickname"
        end
      end
    end

    column :active
    column :created_at

    column :game_id do |round|
      if round.game_id.present?
        link_to "#{round.game.title}",
          admin_game_path(round.game)
      else
        status_tag('Empty')
      end
    end

    column :notes

    actions
  end

  # SHOW page ( rows )
  show do |event|
    attributes_table do

      row :game_id do |round|
        link_to "#{round.game.title}",
          admin_game_path(round.game)
      end

      row :active

      row :kata_name do |round|
        b em " Link to CodeWars: "
        if round.kata_id.present?
          link_to "#{round.kata_name}",
            "https://www.codewars.com/kata/#{round.kata_id}", target: "_blank"
        else
          status_tag('No Kata ID')
        end
      end

      row :duration

      row :winners do |round|
        round.winners.each do |winner_id|
          winner = User.find(winner_id)
          if winner.nickname.present?
            div b small link_to "☆ #{winner.nickname} ☆",
                   admin_user_path(round.id, winner)
            em "#{winner.email}"
          else
            # li em "no nickname"
            div b small link_to "☆ #{winner.email} ☆",
                   admin_user_path(round.id, winner)
          end
        end
      end

      row :participations do |round|
        if round.participations.present?
          b "This round has in total #{round.participations.count} participation(s)"
          ul do
            round.participations.map do |partic|
              div link_to("Participation ID #{partic.id}",
                    admin_participation_path(partic))
              div b small "Active: #{partic.active}"
              div b small "Done: #{partic.done}"
              em "- - - - - - - - - - § - - - - - - - - - - -"
            end
          end
        else
          status_tag('Empty')
        end
      end

      row :notes
    end
    active_admin_comments
  end

  # Form
  form do |f|
    f.inputs "Round info" do
      f.input :kata_id
      f.input :active
      f.input :notes
    end

    f.actions
    f.semantic_errors *f.object.errors.keys
  end


  remove_filter :participations
  remove_filter :winners
end
