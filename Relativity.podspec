Pod::Spec.new do |s|
  s.name     = ‘Relativity’
  s.version  = ‘0.8.0’
  s.license  = 'Apache License, Version 2.0'
  s.summary  = ‘Relativity makes it easy to position views relative to one another without using Auto Layout.’
  s.homepage = 'https://github.com/dfed/Relativity’
  s.authors  = ‘Dan Federman’
  s.source   = { :git => 'https://github.com/dfed/Relativity.git', :tag => s.version }
  s.source_files = 'Sources/*.swift'
  s.ios.deployment_target = '8.0'
end
