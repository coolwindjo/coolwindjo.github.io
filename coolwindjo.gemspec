# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "coolwindjo"
  spec.version       = "1.8.0"
  spec.authors       = ["CoolWind"]
  spec.email         = ["coolwind@hotmail.co.kr"]

  spec.summary       = "Blog posts and pages with cool wind"
  spec.description   = %q{Blog posts and pages with cool wind}
  spec.homepage      = "https://github.com/coolwindjo/coolwindjo.github.io"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README)!i)
  end

  spec.add_development_dependency "bundler", ">= 1.6", "< 3.0"
  spec.add_development_dependency "rake", ">= 12.0", "< 13.0"

  spec.add_runtime_dependency "jekyll", "> 3.5", "< 5.0"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.9"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.1"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.3"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-spaceship", "~> 0.2"
end
