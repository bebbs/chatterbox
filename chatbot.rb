def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2}
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
              'Do you prefer (.*) or (.*) ?' => '%{c1} is alright, but %{c2} is my favourite.'
          }

puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
while(input = gets.chomp) do
  puts get_response(input)

end

