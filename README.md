[![hexlet-check](https://github.com/blackfoxik/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/blackfoxik/rails-project-63/actions/workflows/hexlet-check.yml)

[![CI](https://github.com/blackfoxik/rails-project-63/actions/workflows/main.yml/badge.svg)](https://github.com/blackfoxik/rails-project-63/actions/workflows/main.yml)

Usage:
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

html = HexletCode.form_for user, url: '/users' do |f|
  f.input :name
  f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>