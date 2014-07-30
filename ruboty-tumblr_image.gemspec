lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/tumblr_image/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-tumblr_image"
  spec.version       = Ruboty::TumblrImage::VERSION
  spec.authors       = ["Sunao Komuro"]
  spec.email         = ["konbu.komuro@gmail.com"]
  spec.summary       = "An ruboty handler to pickup images from Tumblr."
  spec.homepage      = "https://github.com/hogelog/ruboty-tumblr_image"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
