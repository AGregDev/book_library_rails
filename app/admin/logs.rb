ActiveAdmin.register Log do
  remove_filter :user

  filter :action
  filter :details
  filter :created_at
end
