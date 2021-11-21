def strip_last_segment(ver)
  ver.sub(/\.\d+$/, '')
end

factory_bot_vers = %w(
  5.0
  6.0
)

activerecord_vers = %w(
  6.0.0
  6.1.0
  7.0.0.alpha
)

factory_bot_vers.product(activerecord_vers).each do |factory_bot_ver, activerecord_ver|
  name = [
    "factory_bot-#{strip_last_segment(factory_bot_ver)}",
    "activerecord-#{strip_last_segment(activerecord_ver)}"
  ].join(' ')

  appraise name do
    gem 'activerecord', "~> #{activerecord_ver}"
    gem 'factory_bot',  "~> #{factory_bot_ver}"
  end
end
