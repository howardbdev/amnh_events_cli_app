class AmnhEventsCliApp::CLI
attr_accessor :events, :type

  def call
    puts "Welcome!"
    list_events
    menu
    goodbye
  end

  def list_events
    puts "Here are types of upcoming events at the American Museum of Natural History (AMNH):"
    AmnhEventsCliApp::Events.list
    puts
  end

  def menu
    input = nil
    puts "Enter the number corresponding to the type of event you'd like more information on or type 'exit':"
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0
        event = @events[input.to_i - 1]
          puts "#{event.name}:"
          puts "#{event.date}"
          # puts "#{event.short_description}"
          puts "Type 'list' to see available types of events again or type 'exit':"
        # elsif input == "tickets"
        #   puts
        #   puts "#{event.tickets}"
        #   puts
        # elsif input == "description"
        #   puts
        #   puts "#{event.detailed_description}"
        #   puts
      elsif input == "list"
        list_events
      else puts "Type 'list' to see available types of events again or type 'exit':"
      end
    end
  end

  def goodbye
    puts "Come back soon!"
  end

end
