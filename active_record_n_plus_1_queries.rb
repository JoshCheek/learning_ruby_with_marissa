require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :name
  end

  create_table :posts do |t|
    t.string :name
    t.integer :user_id
  end

  create_table :comments do |t|
    t.string :body
    t.integer :post_id
  end
end

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

User.create! name: 'Josh' do |u|
  u.posts.build name: 'yo ho ho' do |p|
    p.comments.build body: 'c1'
    p.comments.build body: 'c2'
  end
  u.posts.build name: 'and a bottle of rum' do |p|
    p.comments.build body: 'c3'
    p.comments.build body: 'c4'
  end
end


ActiveRecord::Base.logger = Logger.new $stdout
ActiveSupport::LogSubscriber.colorize_logging = false

user = User.first # => #<User id: 1, name: "Josh">

require 'erb'

# Using `includes` https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-includes
#
# OLD
# Comment Load (0.1ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" = ?  [["post_id", 1]]
# Comment Load (0.1ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" = ?  [["post_id", 2]]
#
# NEW
# Comment Load (0.2ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN (?, ?)  [["post_id", 1], ["post_id", 2]]
@posts = user.posts.includes(:comments)

html = ERB.new(<<HTML, trim_mode: '<>-').result(binding)
<ul>
  <% @posts.each do |post| -%>
    <% post.comments.each do |comment| -%>
      <li><%= comment.body %></li>
    <% end -%>
  <% end -%>
</ul>
HTML


def html.inspect
  self
end

html
# => "<ul>\n" +
#    "            <li>c1</li>\n" +
#    "          <li>c2</li>\n" +
#    "                <li>c3</li>\n" +
#    "          <li>c4</li>\n" +
#    "      </ul>\n"

# >> D, [2020-12-08T12:26:40.058707 #32407] DEBUG -- :   User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
# >> D, [2020-12-08T12:26:40.069515 #32407] DEBUG -- :   Post Load (0.2ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 1]]
# >> D, [2020-12-08T12:26:40.077961 #32407] DEBUG -- :   Comment Load (0.2ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN (?, ?)  [["post_id", 1], ["post_id", 2]]
