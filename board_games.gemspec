# frozen_string_literal: true

require_relative "lib/board_games/version"

Gem::Specification.new do |spec|
  spec.name          = "board_games"
  spec.version       = BoardGames::VERSION
  spec.authors       = ["dbrandt1990"]
  spec.email         = ["dvbrandt90@gmail.com"]

  spec.summary       = "Flatiron project, CLI_Data_Gem"
  spec.description   = "List game by popularity, can pick a game and get more info, and offers to find similar games"
  spec.homepage      = "https://github.com/dbrandt1990/CLI_Gem_BoardGames"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = "https://github.com/dbrandt1990/CLI_Gem_BoardGames"
  spec.metadata["source_code_uri"] = "https://github.com/dbrandt1990/CLI_Gem_BoardGames"
  spec.metadata["changelog_uri"] = "https://github.com/dbrandt1990/CLI_Gem_BoardGames"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
