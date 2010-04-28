class String
  def underscore
    str = to_s
    str[0, 1].downcase + str[1..-1].gsub(/[A-Z]/) { |c| "_#{c.downcase}" }
  end
end unless ''.respond_to?(:underscore)