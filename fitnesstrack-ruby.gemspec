spec = Gem::Specification.new do |s|
  s.name = 'fitnesstrack-ruby'
  s.version = '0.0.1'
  s.authors = ['John Russell']
  s.summary = 'Manipulation and processing of fitness tracking files.'
  s.files = Dir['lib/**/*.rb']
  s.add_dependency 'nokogiri', '~>1.6.1'
  s.add_dependency 'rspec', '~>3.2.0'
  s.add_dependency 'rspec-core', '~>3.2.0'
  s.add_dependency 'shoulda-matchers', '~>2.8.0'
  s.add_dependency 'activesupport-core-ext', '~> 4.0.0.2'

  
end

