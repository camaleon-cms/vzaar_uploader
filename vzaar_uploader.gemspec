$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "vzaar_uploader/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "vzaar_uploader"
  s.version     = VzaarUploader::VERSION
  s.authors     = ["Owen Peredo"]
  s.email       = ["owenperedo@gmail.com"]
  s.homepage    = ""
  s.summary     = "Vzaar video uploader plugin for Camaleon CMS."
  s.description = "Vzaar video uploader plugin for Camaleon CMS."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.1"
  s.add_dependency "camaleon_cms", ">= 2.4.3.7"
  s.add_development_dependency "sqlite3"
end
