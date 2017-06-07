class PodcastValidator < ActiveModel::Validator

  def validate(record)
    unless record.uri.starts_with? 'https://www.mixcloud.com/'
      record.errors[:uri] << "This doesn't look like a valid MixCloud URL"
    end
  end

end
