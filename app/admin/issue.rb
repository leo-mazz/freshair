ActiveAdmin.register Issue do

  menu :parent => "Site Admin"

  permit_params :description, :email, :solved

end
