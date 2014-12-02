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
		puts "Thanks for chatting with Chatbot!"
		exit
	else
  		bot_response("#{get_response(input)}")
  	end

end

