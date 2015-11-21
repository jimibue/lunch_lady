require 'json'

#Create a hash using JSON
file = File.read('menu.json')
@menu_hash = JSON.parse(file)
@menu_items = @menu_hash["menu"]["items"]

@main_dishes = @menu_items.select {|item| item if item["category"] == "main"}
@side_dishes = @menu_items.select {|item| item if item["category"] == "side"}

def print_item(item)
	puts"#{item["item"]}) #{item["name"]}: $#{item["price"]} "
end

def print_menu(menu)
	menu.each {|item| print_item(item)}
end

def get_selection(menu)
	puts "Please make a selection"
	input = gets.strip
	return input if input == 'q'
	menu[input.to_i - 1]
end

def message
	puts "\nPlease make a selection or hit 'q' to finish order. \nYou have $#{@money} left\n"
end

@money = 100

message
print_menu(@main_dishes)
main_item = get_selection(@main_dishes)
@money -= main_item["price"]

while true
	message
	print_menu(@side_dishes)
	side_item = get_selection(@side_dishes)
	break if side_item == 'q'
	if @money - side_item["price"] < 0
		puts "NOT ENOUGH MONEY!!!!!!"
		message
	else
		@money = @money - side_item["price"]
		puts "Remaining #{@money}"
	end
end



