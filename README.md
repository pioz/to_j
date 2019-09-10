# ToJ

[![Build Status](https://travis-ci.org/pioz/to_j.svg?branch=master)](https://travis-ci.org/pioz/to_j)
[![Coverage Status](https://coveralls.io/repos/github/pioz/to_j/badge.svg?branch=master&service=github)](https://coveralls.io/github/pioz/to_j)
[![Github Actions](https://github.com/pioz/to_j/workflows/Test/badge.svg)](https://github.com/pioz/to_j/actions)

ToJ is a helpful gem that allows you to build json from your active model
object or collection. ToJ allows you to define a Serializer with many methods
called `views`. A view is a method that describe how to generate json. So
if you want to generate a json with only the author data you can use
`author.to_j`, but if you want add also the books you can use
`author.to_j(view: :with_books)`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'to_j'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install to_j
```

## Usage

In your models include the ToJ module:

```ruby
class Author < ApplicationRecord
  include ToJ
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  include ToJ
  belongs_to :author

  def nice_title
    self.title.titleize
  end
end
```

Then in the `app/serializers` directory create a serializer for each model:

```ruby
# app/serializers/author_serializer.rb
module AuthorSerializer

  def default(author, options = {})
    self.extract!(author, :id, :name)
    if options[:user]&.admin?
      self.extract!(author, :email)
    end
  end

  def with_books(author, options = {})
    default(author, options)
    self.books do
      self.array!(author.books.map { |book| book.to_j(options) })
    end
  end

end
```

```ruby
# app/serializers/book_serializer.rb
module BookSerializer

  def default(book, options = {})
    self.extract!(book, :id, :title, :nice_title)
  end

  def only_title(book, options = {})
    self.extract!(book, :title)
  end

end
```

The default view is called if the option `:view` is not present on `to_j`
options param.

Now you can call:

```ruby
Author.limit(100).to_j
# [{"id"=>1028680, "name"=>"Kristopher", {...}, ...]
Author.limit(100).to_j(view: :with_books)
# [{"id"=>1028680, "name"=>"Kristopher", "books"=>[{"id"=>192756823, "title"=>"If not now, when?", "nice_title"=>"If Not Now, When?"}, {...}, ...]
Book.first.to_j(view: :only_title)
# {"title"=>"Jesting pilate"}
```

or in your controllers:

```ruby

def index
  @authors = Author.limit(100)
  respond_to do |format|
    format.html
    format.json { render json: @authors.to_j(user: current_user) }
  end
end

def show
  @author = Author.find(params[:id])
  respond_to do |format|
    format.html
    format.json { render json: @author.to_j(view: :with_books) }
  end
end

```

If a serializer or `default` method is not defined all table columns will be
added in the json (default Rails behavior).

### Under the hood there is Jbuilder

The `self` object in serializer's methods are a Jbuilder object so you can use
the [Jbuilder](https://github.com/rails/jbuilder/) DSL to create and
personalized your json views.

## Performance

In the `test` directory I've write a simple benchmark to check the performance of this gem with other common serializers:

- [as_json](http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json)
- [active_model_serializers](https://github.com/rails-api/active_model_serializers/)
- [Jbuilder](https://github.com/rails/jbuilder/)

Here the results to build a json of `10_000` authors with a total of `100_000` books:

```
Run options: --seed 333

# Running:

         user        system    total     real
to_j      9.950000   0.340000  10.290000 ( 10.367328)
as_json  15.460000   0.400000  15.860000 ( 15.942882)
ams      16.000000   0.460000  16.460000 ( 16.578348)
jbuilder  9.940000   0.380000  10.320000 ( 10.305331)

```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
