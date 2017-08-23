ActiveAdmin.register Setting do

  menu :parent => "Site Admin"
  
  permit_params :key, :value

end
