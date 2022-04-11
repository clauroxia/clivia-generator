require "htmlentities"
module Requester
  def select_main_menu_action
    # prompt the user for the "random | scores | exit" actions
    options = ["random", "scores", "exit"]
    puts options.join(" | ")
    print "> "
    prompt = gets.chomp
    gets_option(prompt, options)
  end

  def ask_question(question)
    coder = HTMLEntities.new
    matriz = ["Category: #{question[:category]}", "Difficulty: #{question[:difficulty]}"]
    puts matriz.join(" | ")
    puts coder.decode(question[:question])
    alternatives = question[:incorrect_answers]
    alternatives.push(question[:correct_answer])
    correct_answer = question[:correct_answer]
    id = 0
    option = {}
    alternatives.shuffle.each do |alternative|
      puts "#{id = id.next}. #{coder.decode(alternative)}"
      option[id] = alternative
      option.merge(option)
    end
    print "> "
    number_option = gets.chomp.to_i
    ask_questions(option, number_option, correct_answer)
  end

  def will_save?(score)
    puts "Well done! Your score is #{score}"
    puts "--------------------------------------------------"
    puts "Do you want to save your score? (y/n)"
    print "> "
    answer = gets.chomp.downcase
    if answer == "y"
      puts "Type the name to assign to the score"
      print "> "
      score_name = gets.chomp.capitalize
      score_name = "Anonymous" if score_name.empty?
      save({ name: score_name, score: score })
    end
    # prompt the user to give the score a name if there is no name given, set it as Anonymous
  end

  def gets_option(prompt, options)
    until options.include?(prompt)
      puts "Invalid option" unless options.include?(prompt)
      print "> "
      prompt = gets.chomp
    end
    prompt
  end
end
