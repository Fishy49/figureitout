require 'active_support/inflector'
require "faker"
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
  locals = {
    intro: INTRO_SENTENCES.sample,
    author: Faker::Name.name_with_middle,
    farewell: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    expertise: Faker::Company.catch_phrase.pluralize,
    company_name: Faker::Company.name,
    languages: rand(3..6).times.map { |i| Faker::ProgrammingLanguage.name }.join(", ").sub(/.*\K, /, " and "),
    quote: Faker::Marketing.buzzwords.titleize,
    footer_type: Faker::Company.type
  }
  erb :page, locals: locals.merge(title: "How Do I Solve All My Problems?")
end

get "/:title" do
  locals = {
    intro: INTRO_SENTENCES.sample,
    author: Faker::Name.name_with_middle,
    farewell: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    expertise: Faker::Company.catch_phrase.pluralize,
    company_name: Faker::Company.name,
    languages: rand(3..6).times.map { |i| Faker::ProgrammingLanguage.name }.join(", ").sub(/.*\K, /, " and "),
    quote: Faker::Marketing.buzzwords.titleize,
    footer_type: Faker::Company.type
  }
  erb :page, locals: locals.merge(title: params[:title].titleize.gsub("-", " "))
end
