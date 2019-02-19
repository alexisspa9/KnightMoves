class Square
	attr_reader :x, :y, :children, :parent
	def initialize(x,y, parent=nil)
		@x = x
		@y = y
		@children = []
		@parent = parent
	end

	def make_children
		#clear the children
		@children = []
		candicates = []
		#push all possible knight moves
		candicates.push([@x + 2, @y + 1]).push([@x + 2, @y - 1])
		candicates.push([@x + 1, @y + 2]).push([@x + 1, @y - 2])
		candicates.push([@x - 2, @y + 1]).push([@x - 2, @y - 1])
		candicates.push([@x - 1, @y + 2]).push([@x - 1, @y - 2])
		#select only the valid ones
		children = candicates.select {|cand| cand[0] >= 0 && cand[0] <= 7 &&  cand[1] >= 0 && cand[1] <= 7}
		#map candicates in Square objects
		children = children.map {|cand| Square.new(cand[0],cand[1],self)}
		@children = children
	end

	def get_search_obj(search_obj, root_obj)
		queue = []
		queue << root_obj

		until queue.empty?
			current = queue.shift
			return current if current.x == search_obj.x && current.y == search_obj.y
    		current.make_children.each {|child| queue << child}
		end
	end

	def get_route(root_arr, search_arr)
		start = Square.new(root_arr[0], root_arr[1])
		finish = Square.new(search_arr[0], search_arr[1])
		result = get_search_obj(finish, start)

		route = []
		route.unshift([finish.x, finish.y])
		current = result.parent
		until current.nil?
			route.unshift([current.x, current.y])
    		current = current.parent
		end

		puts "You made it in #{route.length - 1} moves! Here's your route:"
		route.each {|square| puts square.inspect}
		return nil
		
	end


end

my_square = Square.new(3,3)
my_square.get_route([0,0],[3,3])
my_square.get_route([3,3],[0,0])
my_square.get_route([3,3],[4,3])