class TagValidator <  ActiveModel::Validator

 def validate(record)
   if record.is_post_type && record.is_highlighted
     record.errors[:is_highlighted] << 'You cannot highlight a post type'
   end

   if record.is_highlighted && record.pic.url.blank?
     record.errors[:pic] << 'To highlight a tag assign a picture to it'
   end
 end

end
