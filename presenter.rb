require_relative "requester"
require "terminal-table"

module Presenter
  def print_welcome
    puts "###################################"
    puts "#   Welcome to Clivia Generator   #"
    puts "###################################"
  end
  
  def print_score(json)
    table = Terminal::Table.new
    table.title = "Top Scores"
    table.headings = ["Name", "Score"]
    table.rows = json.map do |a|
                  a.to_a.map { |b| b[1]}
                end
    puts table
    # print the score message
    # tabla
  end
end

