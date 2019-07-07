ActiveAdmin.register Game do

  # Strong PARAMS
  permit_params :title, :max_rounds, :notes, :user_id

  # INDEX page
  index do
    selectable_column
    column :id

    column :user_id do |game|
      b "☆Winner☆ "
      if game.user_id.present?
        div link_to "#{game.user.nickname} - #{game.user.email}",
              admin_user_path(game.user)
      else
        status_tag('Empty')
      end
    end

    column :title do |game|
      if game.title.present?
        link_to "#{game.title}",
          admin_game_path(game)
      else
        status_tag('Empty')
      end
    end
    column :max_rounds
    column :notes
    column :created_at
    actions
  end

  # SHOW page ( rows )
  show do |event|
    attributes_table do

    row :user_id do |game|
      b "☆WINNER☆: "
      if game.user_id.present?
        div link_to "#{game.user.nickname} - #{game.user.email}",
              admin_user_path(game.user)
      else
        status_tag('Empty')
      end
    end

    row :max_rounds

    row :rounds do |game|
      if game.rounds.present?
        b "This Game has in total #{game.rounds.count} rounds(s)"
        ul do
          game.rounds.map do |round|
            div b link_to("Id. #{round.id} - #{round.kata_name}",
                    admin_round_path(round))
            div b "Kata Name: #{round.kata_name}"
            div "Kata id: #{round.kata_id}"
            div "Duration: #{round.duration}"
            div "Active: #{round.active}"
            em "- - - - - - - - - - - - - - § - - - - - - - - - - - - - - -"
          end
        end
      else
        status_tag('Empty')
      end
    end

    row :notes
        # row :status do |l|
        #   b l.status.capitalize
        # end
    end
    active_admin_comments
  end

  # # Form
  form do |f|
    f.inputs "Game info" do
      f.input :title
      f.input :max_rounds
      f.input :notes
    end

    # f.inputs "Rounds" do
    #   f.has_many :rounds, heading: false do |o|
    #     o.input :kata_id
    #     o.input :duration
    #     o.input :notes
    #     o.input :active
    #     o.input :winners
    #   end
    # end

    f.actions
    f.semantic_errors *f.object.errors.keys
  end


  preserve_default_filters! # DEAFAULT filters

  remove_filter :rounds
  remove_filter :user

  # filter :rounds, as: :select, collection: Round.all.map do |r|
  #   r.kata_name
  # end
  # filter :round_id, label: "Round - kata name", collection: -> {
  #   Round.all.map { |r| r.kata_name }.sort
  # }
  # remove_filter :tutor
  # remove_filter :reviewer_id
end
