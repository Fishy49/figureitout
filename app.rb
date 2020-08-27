require "sinatra"
require "titleize"

INTRO_SENTENCES = [
  "There's really only one solution to this:",
  "You can approach this a number of ways but the best way is:",
  "I can't stress this enough. Rule #1 for problems like this:",
  "Luckily the solution is pretty straightforward. Just do the following:",
  "My time-honored approach to this problem can be found below:"
]

get "/" do
  erb :page, locals: { title: "How Did I Solve All My Problems?", intro: INTRO_SENTENCES.sample }
end

get "/:title" do
  erb :page, locals: { title: params[:title].titleize.gsub("-", " "), intro: INTRO_SENTENCES.sample }
end
