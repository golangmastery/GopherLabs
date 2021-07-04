# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "GopherLabs"
  spec.version       = "2.2.6"
  spec.authors       = ["sangam"]
  spec.email         = ["kubedaily@gmail.com"]

  spec.summary       = %q{A super customizable Jekyll theme for personal site, team site, blog, project, documentation, etc.}
  spec.homepage      = "https://github.com/sangam14/GopherLabs"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^((_data|_includes|_layouts|_sass|assets)/|(LICENSE|README|CHANGELOG)((\.(txt|md|markdown)|$)))}i)
  end

  spec.add_runtime_dependency "jekyll", ">= 3.6", "< 5.0"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.0"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.1"
  spec.add_runtime_dependency "jemoji", "~> 0.8"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3"
end
