class AmnhEventsCliApp::Events
attr_accessor :event, :name, :type, :date, :short_description, :url_text, :url, :time, :location, :tickets, :detailed_description
@@all = []

def self.all
  @@all
end

def self.get_page
  @doc = Nokogiri::HTML(open("https://www.amnh.org/calendar?facetsearch=1"))
  # binding.pry
end

def self.get_events
  self.get_page.css(".mod.event")
  # binding.pry
end

def self.make_events
  self.get_events.each do |post|
    event = AmnhEventsCliApp::Events.new
    # binding.pry
    @@all << event
    event.type = post.css("p.category").text
    event.name = post.css("a").text.strip
    event.date = post.css("p.date").text
    event.short_description = post.css("p").text
    event.url = post.css("a").first["href"]
    # binding.pry
  end
  self.all
  # binding.pry
end

def self.sort_events
  self.make_events.sort_by! {|event| event.type}
  # binding.pry
end

def self.make_types
  self.sort_events.uniq {|event| event.type}
end

def self.print_types
  # binding.pry
  self.make_types.each.with_index(1) do |event, i|
    puts "#{i}. #{event.type}"
  end
  # puts "1. LECTURES AND TALKS"
  # puts "2. MEMBERS PROGRAMS"
  # puts "3. COURSES AND WORKSHOPS"
  # puts "4. AFTER HOURS PROGRAMS"
  # puts "5. SPECIAL EVENTS"
end

end
