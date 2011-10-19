YAML.load_file(Rails.root.join("config", "settings.yml"))[Rails.env].each do |key, value|
  if Rails.configuration.respond_to?(key)
    raise "Configuration key `#{key}` found in your settings.yml is already in use"
  end
  Rails.configuration.send("#{key}=", value.is_a?(Hash) ? OpenStruct.new(value) : value )
end