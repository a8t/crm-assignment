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
get "/about" do
  @skills = ["HTML/CSS", "Javascript", "Ruby"]
  @interests = ["bikes", "tetris","physics"]
  erb(:about)
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
  erb :show_contact
else
  erb :error
end
end

after do
  ActiveRecord::Base.connection.close
end
