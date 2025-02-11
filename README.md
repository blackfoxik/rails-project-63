[![hexlet-check](https://github.com/blackfoxik/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/blackfoxik/rails-project-63/actions/workflows/hexlet-check.yml)

[![CI](https://github.com/blackfoxik/rails-project-63/actions/workflows/main.yml/badge.svg)](https://github.com/blackfoxik/rails-project-63/actions/workflows/main.yml)

# HexletCode is a DSL that makes it easy to generate forms

A library with which it is convenient to create forms in site templates. This is a popular task for which there are many libraries, such as the [library](https://guides.rubyonrails.org/form_helpers.html) built into Rails or the popular [SimpleForm](https://github.com/heartcombo/simple_form) gem.

## Installation

Bundler has the ability to install gems directly from git repositories. Installing a gem using git is as easy as adding a gem to your Gemfile:

```
gem 'hexlet_code', git: 'https://github.com/blackfoxik/rails-project-63.git'
```

Install dependencies from your Gemfile:

```sh
bundle install
```

## How to use

```ruby
require 'rubygems'
require 'bundler/setup'
require 'hexlet_code'

# Create a User class with name, job and gender fields:
User = Struct.new(:name, :job, :gender, keyword_init: true)

# Create a specific user and fill in the fields:
user = User.new name: 'rob', job: 'hexlet'

# This user is then used to generate the HTML form:
HexletCode.form_for user do |f|
  f.input :name
  f.input :gender
  f.input :job, as: :text
  f.submit
end
=>
# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="rob">
#   <label for="gender">Gender</label>
#   <input name="gender" type="text" value="">
#   <label for="job">Job</label>
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
#   <input type="submit" value="Save">
# </form>
```

For fields, you can specify additional attributes in the form of a hash as the last parameter:

```ruby
HexletCode.form_for user, url: '#' do |f|
  f.input :name, class: 'user-input'
  f.input :job
end
=>
# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="rob" class="user-input">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
# </form>
```

Fields can have default values that can be overridden:

```ruby
HexletCode.form_for user do |f|
  f.input :job, as: :text, rows: 30, cols: 30
  f.submit
end
=>
# <form action="#" method="post">
#   <label for="job">Job</label>
#   <textarea name="job" cols="30" rows="30">hexlet</textarea>
#   <input type="submit" value="Save">
# </form>
```

By default, the submit() method uses 'Save' as the button's name, but it can be overridden by passing the desired text as the first argument. The generator can accept a url, in which case it will be used as the address when submitting the form:

```ruby
HexletCode.form_for user, url: '/users' do |f|
  f.input :job, as: :text, rows: 50, cols: 50
  f.submit 'Wow'
end
=>
# <form action="/users" method="post">
#   <label for="job">Job</label>
#   <textarea name="job" cols="50" rows="50">hexlet</textarea>
#   <input type="submit" value="Wow">
# </form>
```

It is also possible to change/add form attributes:

```ruby
HexletCode.form_for user, url: '/profile', method: :get, class: 'hexlet-form', &:submit
=>
# <form action="/profile" method="get" class="hexlet-form">
#   <input type="submit" value="Save">
# </form>
```
