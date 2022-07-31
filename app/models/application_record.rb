class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.per_page
    10
  end
end
