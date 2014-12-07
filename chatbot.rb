def get_response(input)
    key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
    /#{key}/ =~ input
    response = RESPONSES[key]
    response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3, c4: $4}
end

def ask_user
	print "User: "
	gets.chomp
end

def bot_response(response)
	puts "Chatbot: #{response}"
end

def add_response
	puts "What question would you like to add?: "
	q = gets.chomp
	puts "What response would you like for '#{q}'?"
	a = gets.chomp
	RESPONSES[q] = a
    puts "Response added!"
end

def save_questions
    file = File.open("questions.csv", "w")
    RESPONSES.each do |key, value|
        file.print "['#{key}', "
        file.puts "'#{value}']"
    end
    file.close
    puts "Questions have been saved to questions.csv!"
end

def save_and_quit
    puts "Thanks for chatting with chatbot!"
    save_questions
    exit
end


RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
              'Where are you?' => 'I am at Old Street Station',
              'What is your name?' => 'My name is ChatBot',
              'Who created you?' => 'Makers Academy created me',
              'My favourite programming language is (.*)' => 'I quite like %{c1} - I was coded in Ruby!',
              'Do you prefer (.*) or (.*) ?' => '%{c1} is alright, but %{c2} is my favourite.',
              'My favourite songs are (.*), (.*), and (.*)' => '%{c1} is okay, %{c3} is very good, but %{c2} sounds awful!'
          }

puts "Hello, what's your name?"
print "User: "
name = gets.chomp
bot_response("Hello #{name}")
while(input = ask_user) do
	if input == "quit"
        save_and_quit
	elsif input == "Add a response"
		add_response
	else
  	bot_response("#{get_response(input)}")
  end

end

