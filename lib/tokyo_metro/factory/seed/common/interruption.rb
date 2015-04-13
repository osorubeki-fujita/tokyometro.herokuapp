module TokyoMetro::Factory::Seed::Common::Interruption

  def self.start!
    puts ""
    puts "Complete! Do you want to continue? \[yn\]"
    go_to_next_process
  end

  class << self

    private

    def go_to_next_process
      yn = get_yn
      case yn
      when "y"
        puts "Go to next process!"
        puts ""
      when "n"
        puts "Please input \'y\' if you want to go to next process."
        puts ""
        self.send( __method__ )
      end
    end

    def get_yn
      yn = gets.chomp.downcase
      case yn
      when "y" , "n"
        return yn
      else
        puts "Please input \'y\' or \'n\'."
        self.send( __method__ )
      end
    end

  end

end