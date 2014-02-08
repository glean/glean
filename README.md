# Glean - A data management tool for humans

___Glean is experimental, expect breaking changes until v1.0.0___

## About
Glean targets __human curated__ datasets, with a goal of easy collaboration.

Data is stored in the human readable data format, [TOML](https://github.com/mojombo/toml). You can think of it as Markdown for data. Each dataset is stored in a git repository, which makes it easy to track revisions, propose changes, and collaborate on datasets.

Each file represents one piece of data (a hash of hashes). Filenames and directory structure are not significant to the data, but are useful for organization and human collaboration via Pull Requests.

## Goals
* Easily pull commonly used datasets into projects
* Curate data using Pull Requests
* Preserve attribution for contributors

## Sources
Glean datasets are available from three distinct sources:

1. [Core](http://github.com/glean)
  * Available via search
  * Hosted on the Glean GitHub organization
1. [Contrib](https://github.com/glean/glean-contrib)
  * Available via search using --contrib
  * Hosted on GitHub and cataloged by Glean Contrib 
1. User 
  * TODO
  * Directly available via URL

## Installation
```
$ gem install glean
```

__Requirements:__
* Git

## Command line
```
$ glean help
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

### Examples
```
$ glean export countries --format=json
{"name":"Andorra","code":"ad"}
{"name":"United Arab Emirates","code":"ae"}
{"name":"Afghanistan","code":"af"}
...
```
```
$ glean export us-states --format=yaml
--- !ruby/hash:Hashie::Mash
name: Alaska
abbreviation: ak
--- !ruby/hash:Hashie::Mash
name: Alabama
abbreviation: al
--- !ruby/hash:Hashie::Mash
name: Arkansas
abbreviation: ar
...
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

```
$ rake db:seed
```

## Other Frameworks

I'm not sure how you'd do it, but I want to make it easy. Open an issue, or better yet drop some code in a Pull Request.
