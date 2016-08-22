ActiveAdmin.register Card do

  permit_params :original_text, :translated_text, :block, :user

  # Enable filter
  config.filters = true
  filter :original_text
  filter :translated_text

  index do
    column :original_text
    column :translated_text
    column :block
    column :user
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :original_text
      f.input :translated_text
      f.input :block
    end
    f.submit
  end


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
