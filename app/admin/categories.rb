ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions
  end

  after_create do |category|
    Log.create(user: current_user, action: "Created Category", details: "Admin #{current_user.email} created category #{category.name}")
  end

  after_update do |category|
    Log.create(user: current_ser, action: "Updated Category", details: "Admin #{current_user.email} updated category #{category.name}")
  end

  after_destroy do |category|
    Log.create(user: current_user, action: "Deleted Category", details: "Admin #{current_user.email} deleted category #{category.name}")
  end
end
