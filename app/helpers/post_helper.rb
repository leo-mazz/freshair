module PostHelper

  def rating(score)
    score = score.to_i
    result = ''
    unless !PostMetadatum.valid_rating?(score)
      result += '<div class="rating">'
      half_score = score / 2
      (1..half_score).each do
        result += '<i class="fa fa-star" aria-hidden="true"></i>'
      end
      if score.odd?
        result += '<i class="fa fa-star-half-o" aria-hidden="true"></i>'

        (half_score+2..5).each do
          result += '<i class="fa fa-star-o" aria-hidden="true"></i>'
        end

      else

        (half_score+1..5).each do
          result += '<i class="fa fa-star-o" aria-hidden="true"></i>'
        end

      end
      result += '</div>'
    end
    result
  end

end
