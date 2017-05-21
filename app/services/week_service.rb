class WeekService

  def self.days_dic
    Hash[Date::DAYS_INTO_WEEK.map{|day,integer| [day.to_s.titleize, integer+1]}]
  end

  def self.days_dic_reverse
    Hash[Date::DAYS_INTO_WEEK.map{|day,integer| [integer+1, day.to_s.titleize]}]
  end

end
