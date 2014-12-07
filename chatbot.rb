RESPONSES = {}

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

def get_difference?(hash1, hash2)
    difference = {}
end

def load_questions
    file = File.open("questions.csv", "r")
    file.readlines.each do |line|
        key, value = line.chomp.split(" | ")
        RESPONSES[key] = value
    end
    puts "Questions and responses loaded!"
    puts ""
end

def save_questions
    file = File.open("questions.csv", "w")
    RESPONSES.each do |key, value|
        file.puts key + " | " + value
    end
    file.close
    puts "Questions have been saved to questions.csv!"
end

def save_and_quit
    puts "Thanks for chatting with chatbot!"
    save_questions
    exit
end

def program_loop
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
end

def start_program
    load_questions
    program_loop
end

start_program

