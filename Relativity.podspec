Pod::Spec.new do |s|
  s.name     = ‘Relativity’
  s.version  = ‘0.8.0’
  s.license  = 'Apache License, Version 2.0'
  s.summary  = ‘A DSL for laying out views without Auto Layout in Swift.’
  s.homepage = 'https://github.com/dfed/Relativity’
  s.authors  = ‘Dan Federman’
  s.source   = { :git => 'https://github.com/dfed/Relativity.git', :tag => s.version }
  s.source_files = 'Sources/*.swift'
  s.ios.deployment_target = '8.0'
end
