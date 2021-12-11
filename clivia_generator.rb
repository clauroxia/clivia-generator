require "httparty"
require "htmlentities"
require_relative "presenter"
require_relative "requester"


class CliviaGenerator
  include Presenter
  include Requester
  include HTTParty
  @@name = ARGV
  def initialize
    # we need to initialize a couple of properties here
    @@name.empty? ? @filename = "scores.json" : @filename = @@name
    @score = 0
    @hash = JSON.parse(File.read(@filename), {symbolize_names: true})

  end

  def start
    action = ""
    until action == "exit"
      print_welcome
      action = select_main_menu_action
      case action
      when "random" then random_trivia
      when "scores" then print_score(@hash)
      end
    end
  end

  def random_trivia
    # load the questions from the api
    questions = load_questions[:results]
    # pp questions
    # questions are loaded, then let's ask them
    questions.map do |question|
      ask_question(question)
    end
    will_save?(@score)
  end

  def ask_questions(option, number_option, correct_answer)
    if option[number_option] == correct_answer
      puts "#{option[number_option]}... Correct!"
      @score += 10
    else
      puts "#{option[number_option]}... Incorrect!"
      puts "The correct answer was: #{correct_answer}"
    end
    # ask each question
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
  end

  def save(data)
    @hash.push(data)
    File.write(@filename, @hash.to_json)
    # write to file the scores data
  end

  def load_data
    JSON.parse(File.read(@filename), {symbolize_names: true})
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    response = HTTParty.get("https://opentdb.com/api.php?amount=10")
    JSON.parse(response.body, symbolize_names: true)
  end

  def parse_questions
    # questions came with an unexpected structure, clean them to make it usable for our purposes
    
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end

trivia = CliviaGenerator.new
trivia.start
