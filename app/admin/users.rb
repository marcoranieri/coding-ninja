ActiveAdmin.register User do

  # Strong Params
  permit_params :nickname, :codewars_username, :admin, :photo

  # Index page
  index do
    selectable_column
    column :id
    column :email
    column :nickname
    column :codewars_username
    column :total_participations do |user|
      b user.participations.count
    end
    column :total_wins do |user|
      b Game.where(user: user).count
    end
    column :created_at
    column :admin
    actions
  end

  # Form
  form do |f|
    f.inputs "Identity" do
      f.input :nickname
      f.input :email
      f.input :codewars_username
    end
    f.inputs "Photo" do
      f.input :photo
    end
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
    f.semantic_errors *f.object.errors.keys
  end
  preserve_default_filters!
end
