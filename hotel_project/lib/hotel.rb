require_relative "room"

class Hotel
    attr_reader :rooms
    def initialize(name, hash)
        @name = name
        @rooms = {}

        hash.each do |room, capacity|
            @rooms[room] = Room.new(capacity)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def room_exists?(room_name)
        @rooms.has_key?(room_name)
    end

    def check_in(name, room_name)
        if !room_exists?(room_name)
            p 'sorry, room does not exist'
        elsif @rooms[room_name].add_occupant(name)
            p 'check in successful'
        else
            p 'sorry, room is full'
        end 
    end

    def has_vacancy?
        @rooms.values.any? { |room| room.available_space > 0 }
    end

    def list_rooms
        @rooms.each do |room_name, capacity|
            puts "#{room_name} #{capacity.available_space}"
        end
    end


end
