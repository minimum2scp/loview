class LogLine
  def LogLine.guess_type(s)
    if /^\[\d\d\:\d\d\:\d\d\]\s\*\*\*\s/ =~ s
      :system
    elsif /^\[\d\d\:\d\d\:\d\d\]\s\<.+\>\s/ =~ s
      :user
    else
      :none
    end
  end
end
