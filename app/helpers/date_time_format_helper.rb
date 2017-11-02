module DateTimeFormatHelper

  def format_date(date)
    date.strftime('%A %d %B %Y')
  end

  def format_date_no_year(date)
    date.strftime('%A %d %B')
  end

  def format_date_small(date)
    date.strftime('%d/%m/%Y')
  end

  def format_date_time(date)
    date.strftime('%d/%m/%y %H:%M')
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

end
