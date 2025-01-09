ActiveAdmin.register Library do
  permit_params :name, :location

  index do
    selectable_column
    id_column
    column :name
    column :location
    actions
  end

  form do |f|
    f.inputs "Library Details" do
      f.input :name
      f.input :location
    end
    f.actions
  end

  after_create do |library|
    Log.create(user: current_user, action: "Created Library", details: "Admin #{current_user.email} created library #{library.name}")
  end

  after_update do |library|
    Log.create(user: current_user, action: "Updated Library", details: "Admin #{current_user.email} updated library #{library.name}")
  end

  after_destroy do |library|
    Log.create(user: current_user, action: "Deleted Library", details: "Admin #{current_user.email} deleted library #{library.name}")
  end
end
