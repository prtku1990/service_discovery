class Time
  def as_json(options = nil)
    to_s(:db)
  end
end