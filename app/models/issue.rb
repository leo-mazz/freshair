class Issue < ApplicationRecord

  after_initialize :default_to_non_solved

  validates_presence_of :description, :email
  validates :email, email_format: { message: "should be a valid email address" }

  private
    def default_to_non_solved
      self.solved = false if self.solved.nil?
    end
    
end
