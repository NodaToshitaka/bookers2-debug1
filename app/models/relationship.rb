class Relationship < ApplicationRecord
  belongs_to follwer, class_name:"User"
  belongs_to followed, class_name:"User"
end
