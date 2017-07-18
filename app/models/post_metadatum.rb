class PostMetadatum < ApplicationRecord

  validates_presence_of :post, :key, :value
  validates_uniqueness_of :key, :scope => :post_id
  validates_with PostMetadatumValidator

  belongs_to :post

  def self.allowed_keys
    ['rating']
  end

  def self.allowed_key?(key)
    PostMetadatum.allowed_keys.include?(key)
  end

  def self.valid_rating?(rating)
    num_rating = PostMetadatum.number_or_nil(rating)
    return false if (num_rating.nil? or num_rating > 10 or num_rating < 0)
    true
  end

  private

    def self.number_or_nil(string)
      num = string.to_i
      return num if num.to_s == string.to_s
      return nil
    end

end
