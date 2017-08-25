require "sinatra"
require "./contact.rb"

get "/" do
  erb(:main)
end

get "/about" do
  @skills = ["HTML/CSS", "Javascript", "Ruby"]
  @interests = ["bikes", "tetris","physics"]
  erb(:about)
end

get "/contacts" do
  @collection = Contact.all
  erb(:contacts)
end

get "/contacts/new" do
  erb(:new)
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
  erb :show_contact
  else
    erb :error
  end
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
  erb :show_contact
  else
    erb :error
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    erb :error
  end
end

post "/contacts/" do

  @contact = Contact.find_by(params[:search_by].to_sym => params[:search_value])
puts "hi"
  if @contact
    puts "hello"
    erb :show_contact
  else
    erb :error
  end

end




post '/contacts' do
  Contact.create(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note]
  )

  redirect to('/contacts')
end

put "/contacts/:id" do

  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    erb :error
  end
end

delete '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    erb :error
  end
end

after do
  ActiveRecord::Base.connection.close
end
