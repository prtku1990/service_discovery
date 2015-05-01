source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'slim'
gem 'activerecord', '3.1.3', :require => 'active_record'
gem 'actionpack', '3.1.3'
gem 'activesupport'
gem 'mysql2'

# Test requirements
group :test do
  gem 'simplecov'
  gem 'test-unit', '2.5.5'
  gem "spork"
  gem "spork-testunit"
  gem 'factory_girl'
  gem 'mocha', '0.12.0', :require => false
  gem 'shoulda', '3.0.1'
  gem "shoulda-context", '1.0.0'
  gem "shoulda-matchers", '1.0.0'
  gem 'rack-test', :require => 'rack/test'
end

# Padrino Stable Gem
gem 'padrino', '0.10.5'

gem 'state_machine', '1.1.2'
gem 'state_machine-audit_trail'


# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.5'
# end
