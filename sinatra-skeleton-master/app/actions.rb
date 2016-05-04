# Homepage (Root path)
get '/' do
  erb :index
end

get '/contacts' do
  Contact.all.to_json
end

post '/contacts' do
  contact = Contact.create(
    name: params[:name],
    email: params[:email],
    phone_number: params[:phone_number]
  )
  contact.to_json
end

get '/search/:term' do
  contact_result = Contact.where("name like '%#{params[:term]}%'")
  # puts contact_result
  contact_result.to_json
  # puts params[:term]
end