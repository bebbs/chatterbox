# Create an empty hash to contain questions and responses.
RESPONSES = {}

# get_response is a method to select the correct response for each input, including 4 regex capture groups.
def get_response(input)
    key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
    /#{key}/ =~ input
    response = RESPONSES[key]
    response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3, c4: $4}
end

# ask_user and bot_response handle getting user input and displaying the response. 
def ask_user
	print "User: "
	gets.chomp
end

def bot_response(response)
	puts "Chatbot: #{response}"
end

# add_response allows you to add custom questions and set a response from the chatbot.
def add_response
	puts "What question would you like to add?: "
	q = gets.chomp
	puts "What response would you like for '#{q}'?"
	a = gets.chomp
	RESPONSES[q] = a
    puts "Response added!"
    puts ""
end

# Single responsibility method to open a file in either read or write mode.
def file_handler(filename, mode)
    @file = File.open(filename, mode)
end

# Loads questions.csv in read mode, iterates through and splits each line into 
# key => value, then pushes the pair into the RESPONSES hash.
def load_questions
    file_handler("questions.csv", "r")
    @file.readlines.each do |line|
        key, value = line.chomp.split(" | ")
        RESPONSES[key] = value
    end
    puts "Questions and responses loaded!"
    puts ""
end

# Opens questions.csv in write mode, then appends each key => value pair 
# to the file, split with ' | '. 
def save_questions
    file_handler("questions.csv", "w")
    RESPONSES.each do |key, value|
        @file.puts key + " | " + value
    end
    @file.close
    puts "Questions have been saved to questions.csv!"
end

# Calls save_questions and exits the program.
def save_and_quit
    puts "Thanks for chatting with chatbot!"
    save_questions
    exit
end

# Begins the program by learning the users name.
def say_hello
    puts "Hello, what's your name?"
    print "User: "
    name = gets.chomp
    bot_response("Hello #{name}")
end

# A loop to continually ask for user input, and direct it's response to 
# either quit the program, add a new response, or fetch the bot response.
def program_loop
    while(input = ask_user) do
    	if input == "quit"
            save_and_quit
    	elsif input == "Add a response"
    		add_response
    	else
      	    bot_response("#{get_response(input)}")
        end
    end
end

# Loads the initial set of questions, says hello, then starts the program_loop.
def start_program
    load_questions
    say_hello
    program_loop
end

start_program

