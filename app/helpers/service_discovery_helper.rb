def parse_request
  request.body.rewind
  JSON.parse(request.body.read, :symbolize_names => true, :symbolize_keys => true)
end

def validates_presence_of(*args)
  if args[-1].instance_of? Hash
    map = args[-1][:in] || @input
    key_list = args[0..-2]
  else
    map, key_list = @input, args
  end

  key_list.each do |key|
    raise StandardError.new("Parameter #{key} is mandatory") unless map.has_key?(key) && map[key]
  end

end
