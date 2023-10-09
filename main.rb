require_relative 'app'

class Main
  def run
    puts 'Welcome to our School Library App!'
    app = App.new
    app.start
  end
end

main = Main.new
main.run
