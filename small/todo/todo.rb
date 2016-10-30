require 'yaml'

class Record
	attr_reader :title, :memo

	def initialize(contents={})
  		@title = contents[:title]
		@memo = contents.fetch(:memo, '')
		@complete = contents.fetch(:complete, false)
	end

	def complete?
		@complete
	end

	def toggle_completion
		@complete = !@complete
	end

	def edit(contents={})
		@title = contents.fetch(:title, @title)
		@memo = contents.fetch(:memo, @memo)
	end
end

class List

	def initialize
		@records = []
	end

	def add_record(contents={})
		@records << Record.new(contents)
	end

  def delete(record)
    @records.delete record
  end

	def records
		@records.select { |record| !record.complete? }
	end

	def complete
		@records.select { |record| record.complete? }
	end

	def all
		@records
	end
end

class Database

  def initialize
    @file = 'todo_db'
  end

  def save(list)
    file = File.open(@file, 'w')
    file.write list.to_yaml
    file.close
  end

  def load
    file = File.open(@file, 'r')
    yaml = YAML.load_file file
    file.close
    if yaml
      yaml
    else
      []
    end
  end
end

class Interface

	def initialize
		@list = List.new
    @db = Database.new
    @options = {show: :not_complete}
		clear_screen
		start_screen
    load_list
		get_command
	end

	def get_command
      things = @list.records.map { |record| record.title }
      show({things: things, no_clear_screen: true})
		loop {
			print '> '
			command = gets.chomp
			case command[0]
			when 'a'
				if command[1]
					@list.add_record({title: command[1..-1].strip})
				else
					print 'Enter a title: '
					title = gets.chomp
					unless title.empty?
						@list.add_record({title: title})
					else
						error_message = 'Title cannot be empty!'
					end
				end
			when 'c'
				error_message = make_happen('change_status', things, command)
			when 'e'
				error_message = make_happen('edit', things, command)
			when 'd'
				error_message = make_happen('details', things, command)
      when 's'
        show_switch command
			when 'h'
				show_help
      when 'x'
				error_message = make_happen('delete', things, command)
			when 'q'
				exit
			else
				error_message = 'Command not recognized: ' + command[0].to_s
			end
			things = current_things 
			things_to_show = things.map { |thing| thing.title }
      save_list
			show({things: things_to_show, error_message: error_message})
		}
	end

	private

    def show_switch(command)
      things = ['complete', 'not complete', 'all']
      show({things: things})
      result = choose_entry things, command[1]
      case result[:entry]
      when 0
        @options[:show] = :complete
      when 1
        @options[:show] = :not_complete
      when 2 
        @options[:show] = :all
      end
    end

    def current_things
      case @options[:show]
      when :complete
        @list.complete
      when :not_complete
        @list.records
      when :all
        @list.all
      end
    end

    def save_list
      @db.save @list.all
    end

    def load_list
      @db.load.each do |item|
        contents = {
          title: item.title,
          memo: item.memo,
          complete: item.complete?
        }
        @list.add_record contents
      end
    end

		def make_happen(function, things, command)
			result = choose_entry(things, command[1])
			if result[:entry]
				args = {item: things[result[:entry]], command: command[2..-1]}
				#eval("#{function}(args)")
				message = case function
				when 'edit'
					edit(args)
				when 'change_status'
					change_status(args)
				when 'details'
					details(args)
        when 'delete'
          delete(args)
				end
				result[:error_message] = message if message
			end
			error_message = result[:error_message]
		end

		def choose_entry(things, position)
			if things.empty?
				{error_message: 'There are no items for this action!'}
			else
				if position.nil?
					print 'Select item (a-z): '
					entry = gets.chomp[0].ord - 97
				else
					entry = position.ord - 97
				end
				if entry < things.length
					{entry: entry}
				else
					{error_message: 'Entry ' + (entry + 97).chr + ' is not in the range!'}
				end
			end
		end

    def delete(args)
      item = args[:item]
      @list.delete item
      nil
    end

		def details(args)
			item = args[:item]
			clear_screen
			puts "title:\t\t" + item.title
			puts "memo:\t\t" + item.memo
			puts "complete:\t" + item.complete?.to_s
			puts "Press <Enter> to return."
			gets
			nil
		end

		def edit(args)
			item = args[:item]
			args[:command] ? command = args[:command] : command = ''
			local_things = []
			local_things << "title:\t" + item.title << "memo:\t" + item.memo << "complete:\t" + item.complete?.to_s
			clear_screen
			puts 'Select property to edit:'
			show({things: local_things})
			result = choose_entry(local_things, command[0])
			if result[:error_message].nil?
				command = command[1..-1].to_s
				if command.length < 1 && result[:entry] < 2
					print "Enter value: \n> "
					command << gets.chomp
				end
				value = command
				case result[:entry]
				when 0
					change_contents({:item => item, :part => :title, :value => value})
				when 1
					change_contents({:item => item, :part => :memo, :value => value})
				when 2
					change_status({item: item})
				end
				nil
			else
				result[:error_message]
			end
		end

		def change_contents(args)
			args[:item].edit({args[:part] => args[:value]})
		end

		def change_status(args)
			args[:item].toggle_completion
			nil
		end

		def show(args={})
      things = args[:things]
      error_message = args[:error_message]
			clear_screen unless args[:no_clear_screen]
			things.each_index { |i| puts (i + 97).chr + ': ' + things[i] }
			puts 'ERROR: ' + error_message unless error_message.nil?
		end

		def show_help
			clear_screen
			puts "==USAGE=="
			puts "This program uses commands of the following structure:"
			puts "\n\t<key>[+<value>]-<Enter>\n\n"
			puts "Values can be text that is to be entered or a letter to choose an item."
			puts "Values can be entered separately and will be prompted if not given."
			puts "\nList of available commands:\n"
			puts "'a'\tAdd a new item on a list."
			puts "'c'\tToggle item's completion status. Complete items become hidden."
			puts "'d'\tShow item's details."
			puts "'e'\tEdit an item."
			puts "'h'\tShow this message."
			puts "'q'\tQuit."
      puts "'s'\tChange showed items."
			puts "\nPress <Enter> to return."
			gets
		end

		def start_screen
			puts "A simple TODO-list.\nType 'h-<Enter>' to get some directions."
		end

		def clear_screen
			print `clear`
		end
end

Interface.new
