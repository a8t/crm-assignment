require "sinatra"
require "./contact.rb"

get "/" do
  erb(:index)
end

get "/contacts" do
  @collection = Contact.all
  erb(:contacts)
end
#
# get "/portfolio" do
#   erb(:gallery)
# end
#
# get "/gallery" do
#   erb(:gallery)
# end
#
# get "/about_me" do
#   @skills = ["HTML/CSS", "Javascript", "Ruby"]
#   @interests = ["bikes", "tetris","physics"]
#   erb(:about_me)
# end
#
# get "/fav_links" do
#   @favourites = ["google.com", "reddit.com","facebook.com"]
#   erb(:fav_links)
# end

after do
  ActiveRecord::Base.connection.close
end
