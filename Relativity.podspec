Pod::Spec.new do |s|
  s.name     = 'Relativity'
  s.version  = '3.2.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'A programmatic layout engine and DSL that provides an alternative to Auto Layout.'
  s.homepage = 'https://github.com/dfed/Relativity'
  s.authors  = 'Dan Federman'
  s.source   = { :git => 'https://github.com/dfed/Relativity.git', :tag => s.version }
  s.source_files = 'Sources/**/*.swift'
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.9'
  s.deprecated = true
  s.deprecated_in_favor_of = 'Paralayout'
end
