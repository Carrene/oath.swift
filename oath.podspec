   Pod::Spec.new do |s|
          #1.
          s.name               = "oath"
          #2.
          s.version            = "0.4.0"
          #3.  
          s.summary         = "Sort description of 'oath' framework"
          #4.
          s.homepage        = "http://www.carrene.com"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Hamed"
          #7.
          			
          #8.
          s.source              = { :git => "https://github.com/Carrene/oath.swift.git", :tag => "0.4.0" }
          #9.
          s.source_files     = "oath", "oath/**/*.{h,m,swift}"
          s.dependency 'CryptoSwift', '~> 0.13.0'
  s.ios.deployment_target = "8.0"

		
    end
