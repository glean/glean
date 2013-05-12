# Glean - A data management tool for humans

## About
Glean targets __human curated__ datasets, with a goal of easy collaboration.

Data is stored in the human readable data format, [TOML](https://github.com/mojombo/toml). You can think of it as Markdown for data. Each dataset is stored in a git repository, which makes it easy to track revisions, propose changes, and collaborate on datasets.

## Datasets
Glean datasets are available from three distinct sources:

* [Core](http://github.com/glean) - Available via search, hosted on the glean GitHub organization
* TODO
  * [Contrib](http://github.com/glean/glean-sources) - Available via search (using --contrib)
  * User - Directly available via URL

## Command line
```
NAME
    glean - A data management tool for humans

SYNOPSIS
    glean [global options] command [command options] [arguments...]

VERSION
    0.0.13

GLOBAL OPTIONS
    --help    - Show this message
    --version - 

COMMANDS
    export - Export a dataset
    get    - Download a dataset by name
    help   - Shows a list of commands or help for one command
    info   - Show dataset information
    search - Search for datasets
```

## Rails

Gemfile:
```ruby
gem 'glean'
```

db/seeds.rb:
```ruby
if Country.count == 0
  countries = Glean::Dataset.new('glean/countries')
  countries.each do |country|
    Country.create :name => country.name, :code => country.code
  end
end
```

## Other Frameworks

I'm not sure how you'd do it, but I want to make it easy. Open an issue, or better yet drop some code in a Pull Request.
