# Replace extension with the name of your extension's .rb file
require './lib/sane-scale'

Gem::Specification.new do |s|
  # Release Specific Information
  #  Replace Extension with the name you used in your extension.rb
  #   in the mdodule with version and date.
  s.version = SaneScale::VERSION
  s.date = SaneScale::DATE

  # Gem Details
  # Replace "extension" with the name of your extension
  s.name = "sane-scale"
  s.rubyforge_project = "sane-scale"
  # Description of your extension
  s.description = %q{Modular, responsive, scalable typography}
  # A summary of your Compass extension. Should be different than Description
  s.summary = %q{A SASS framework for defining and applying typographic styles. Generate a nuanced typographic system that is both modular and responsive with only a few key variables. Using multiple fonts? Sane scale makes it simple to normalize your fonts so they appear visually equal when set to the same size.  }
  # The names of the author(s) of the extension.
  # If more than one author, comma separate inside of the brackets
  s.authors = ["David Fusilier"]
  # The email address(es) of the author(s)
  # If more than one author, comma separate inside of the brackets
  s.email = ["dfusil2@gmail.com"]
  # URL of the extension
  s.homepage = "http://www.davidfusilier.com"

  # Gem Files
  # These are the files to be included in your Compass extension.
  # Uncomment those that you use.

  # README file
  s.files = ["README.md"]

  # CHANGELOG
  # s.files += ["CHANGELOG.md"]

  # Library Files
  s.files += Dir.glob("lib/**/*.*")

  # Sass Files
  s.files += Dir.glob("stylesheets/**/*.*")

  # Template Files
  # s.files += Dir.glob("templates/**/*.*")

  # Gem Bookkeeping
  # Versions of Ruby and Rubygems you require
  s.required_rubygems_version = ">= 1.3.6"
  s.rubygems_version = %q{1.3.6}

  # Gems Dependencies
  # Gem names and versions that are required for your Compass extension.
  # These are Gem dependencies, not Compass dependencies. Including gems
  #  here will make sure the relevant gem and version are installed on the
  #  user's system when installing your gem.
  s.add_dependency("sass",      [">= 3.3"])
  s.add_dependency("compass",   [">= 1.0.3"])
end