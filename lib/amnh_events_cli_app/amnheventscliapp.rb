class AmnhEventsCliApp::Events
attr_accessor :event, :name, :type, :date, :short_description, :url, :time, :location, :tickets, :detailed_description
@@all = []

def all
  @@all
end

def self.list
  self.make_events
  AmnhEventsCliApp::Events.all.each do |event|
    if event.name
      puts "#{event.name}"
    end
  end
  # puts "1. LECTURES AND TALKS"
  # puts "2. MEMBERS PROGRAMS"
  # puts "3. COURSES AND WORKSHOPS"
  # puts "4. AFTER HOURS PROGRAMS"
  # puts "5. SPECIAL EVENTS"
end

def self.make_events
  self.get_events.each do |post|
    @@all << event = AmnhEventsCliApp::Events.new
    event.name = doc.css(".mod").first.css("a").text
    event.short_description = doc.css(".mod").first.css("p").text
    event.date = doc.css(".mod").first.css("p.date").text
    event.time = post.css("").text
    event.type = doc.css(".mod").first.css("p.category").text
    event.detailed_description = post.css("").text
  end

  # @@all << event_1 = self.new
  # event_1.name = "Frontiers Lecture: Planetary Origin Stories"
  # event_1.type = "LECTURES AND TALKS"
  # event_1.date = "Monday, May 14, 2018"
  # event_1.short_description = "By studying and compiling “snapshots” from nearby stars, Alycia Weinberger takes us on a journey back in time to the origins of planets."
  # event_1.url = "https://www.amnh.eorg/calendar/frontiers-lecture-planetary-origin-stories"
  # event_1.time = "7:30 pm"
  # event_1.location = "Enter at 81st Street"
  # event_1.tickets = "$15 ($13.50 seniors, students); $12 Members"
  # event_1.detailed_description = "Swirling disks of dust and gas surround young stars, and these disks contain the building blocks for new planets. It would take 100 million years to see a planet fully form, but luckily there are plenty of planetary systems in development for us to observe. By studying and compiling “snapshots” from nearby stars, Alycia Weinberger takes us on a journey back in time to the origins of planets."

  @@all
end

def self.get_page
  doc = Nokogiri::HTML(open("https://www.amnh.org/calendar?facetsearch=1"))
  # binding.pry
end

def self.get_events
  self.get_page.css(".mod part event")
end

end
