ActiveAdmin.register Log do
  remove_filter :user

  filter :action
  filter :details
  filter :created_at

  index do
    selectable_column
    id_column
    column :user
    column :action
    column :created_at
    column :updated_at
    column :details
  end
end
