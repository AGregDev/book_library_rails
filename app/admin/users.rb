ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: ['user', 'admin'], include_blank: false
    end
    f.actions
  end

  after_create do |user|
    Log.create(user: current_user, action: "Created User", details: "Admin #{current_user.email} created user #{user.email}")
  end

  after_update do |user|
    Log.create(user: current_user, action: "Updated User", details: "Admin #{current_user.email} updated user #{user.email}")
  end

  after_destroy do |user|
    Log.create(user: current_user, action: "Deleted User", details: "Admin #{current_user.email} deleted user #{user.email}")
  end
end
