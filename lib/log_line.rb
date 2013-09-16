class LogLine
  def LogLine.guess_type(s)
    if /^\[\d\d\:\d\d\:\d\d\]\s\*\*\*\s/ =~ s
      :system
    elsif /^\[\d\d\:\d\d\:\d\d\]\s\&lt\;.+\&gt\;\s/ =~ s
      :user
    elsif /^\&lt\;\&lt\;.+\&gt\;\&gt\;/ =~ s
      :title
    else
      :none
    end
  end
end
