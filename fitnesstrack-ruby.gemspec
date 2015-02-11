spec = Gem::Specification.new do |s|
  s.name = 'fitnesstrack-ruby'
  s.version = '0.0.1'
  s.authors = ['John Russell']
  s.summary = 'Manipulation and processing of fitness tracking files.'
  s.files = Dir['lib/**/*.rb']
  s.add_dependency 'nokogiri', '~>1.6.0'
end

