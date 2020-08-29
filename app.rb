require "bundler/setup"

Bundler.require

require "sinatra/reloader" unless ENV["RACK_ENV"] == "production"

INTRO_SENTENCES = [
  "There's really only one solution to this.",
  "You can approach this a number of ways but this one is best.",
  "I can't stress this enough. This is rule #1 for problems like this.",
  "Luckily the solution is pretty straightforward. Just do the following.",
  "My time-honored approach to this problem can be found below."
]

HEADER_PHOTOS = JSON.parse(File.read("header_photos.json"))
ARTICLE_PHOTOS = JSON.parse(File.read("article_photos.json"))
FACES = JSON.parse(File.read("faces.json"))

def generate_locals(title = nil, seed = nil)
  title = "#{params[:title].tr("-", " ").titleize}?" if title
  title ||= "How Do I Solve All My Problems?"

  seed ||= title.hash
  srand seed
  Faker::Config.random = Random.new(seed)

  {
    title: title,
    intro: INTRO_SENTENCES.sample,
    author: Faker::Name.name_with_middle,
    date: Faker::Date.backward(365.days),
    caption: Faker::Hacker.say_something_smart,
    farewell: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    expertise: Faker::Company.catch_phrase.pluralize,
    company_name: Faker::Company.name,
    languages: Array.new(rand(3..6)) { Faker::ProgrammingLanguage.name }.join(", ").sub(/.*\K, /, ", and "),
    quote: Faker::Marketing.buzzwords.titleize,
    footer_type: Faker::Company.type,
    face: FACES.sample,
    header_photo: HEADER_PHOTOS.sample,
    article_photo: ARTICLE_PHOTOS.sample
  }
end

get "/:title?" do
  seed = Time.now.to_i if params[:random].present?

  erb :page, locals: generate_locals(params[:title], seed)
end
