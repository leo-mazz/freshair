class PostMetadatumValidator < ActiveModel::Validator

  def validate(record)

    if !PostMetadatum.allowed_key?(record.key)
      record.errors[:key] << 'This is not valid metadata'
    end

    if record.key == 'rating' and !PostMetadatum.valid_rating?(record.value)
      record.errors[:value] << 'The rating you inserted is not valid'
    end

  end

end
