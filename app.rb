require "bundler/setup"

Bundler.require

require "sinatra/reloader" unless ENV["RACK_ENV"] == "production"

INTRO_SENTENCES = [
  "There's really only one solution to this:",
  "You can approach this a number of ways but the best way is:",
  "I can't stress this enough. Rule #1 for problems like this:",
  "Luckily the solution is pretty straightforward. Just do the following:",
  "My time-honored approach to this problem can be found below:"
]

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
    farewell: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    expertise: Faker::Company.catch_phrase.pluralize,
    company_name: Faker::Company.name,
    languages: Array.new(rand(3..6)) { Faker::ProgrammingLanguage.name }.join(", ").sub(/.*\K, /, " and "),
    quote: Faker::Marketing.buzzwords.titleize,
    footer_type: Faker::Company.type
  }
end

get "/:title?" do
  seed = Time.now.to_i if params[:random].present?

  erb :page, locals: generate_locals(params[:title], seed)
end
