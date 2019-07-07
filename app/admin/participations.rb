ActiveAdmin.register Participation do

  permit_params :active, :done, :user_id, :round_id

  # SHOW page
  show do |event|
    attributes_table do
      row :id
      row :active
      row :done

      row :user do |partic|
        if partic.user.present?
          div link_to("#{partic.user.nickname}",
            admin_user_path(partic.user))
          div em partic.user.email
        else
          status_tag('Empty')
        end
      end

      row :round do |partic|
        if partic.round.present?
          div link_to("#{partic.round.kata_name}",
                admin_round_path(partic.round))
           em "From game:"
           div em link_to("#{partic.round.game.title}",
                 admin_game_path(partic.round.game))
        else
          status_tag('Empty')
        end
      end

    end
    active_admin_comments
  end

  # Form Field #NEW
  form do |f|
    f.inputs "Insert details" do
      f.input :active
      f.input :done
    end
    f.actions
  end

  remove_filter :round
  remove_filter :user

end
