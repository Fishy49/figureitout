require "sinatra"
require "titleize"

get "/" do
  erb :page, locals: { title: "How Did I Solve All My Problems?" }
end

get "/:title" do
  erb :page, locals: { title: params[:title].titleize.gsub("-", " ") }
end
