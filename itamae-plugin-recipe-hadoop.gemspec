lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "itamae/plugin/recipe/hadoop/version"

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-hadoop"
  spec.version       = Itamae::Plugin::Recipe::Hadoop::VERSION
  spec.authors       = ["ichylinux"]
  spec.email         = ["ichylinux@gmail.com"]

  spec.summary       = %q{itamae recipe for apache hadoop installation}
  spec.description   = %q{itamae recipe for apache hadoop installation}
  spec.homepage      = "https://github.com/maedadev/itamae-plugin-recipe-hadoop"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'itamae', '~> 1.10', '>= 1.10.4'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
