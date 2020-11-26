require 'ruby2d'

class Ball
    HEIGHT = 25
    attr_reader :shape
    def initialize
        @x = 320
        @y = 400
        @y_velocity = 1
        @x_velocity = -1
    end

    def move
        if hit_bottom? || hit_top?
            @y_velocity = -@y_velocity
        end
        @x = @x + @x_velocity
        @y = @y + @y_velocity
    end

    def draw
        @shape = Square.new(
            x: @x,
            y: @y,
            size: HEIGHT,
            color: 'white'
        )
    end

    def bounce
        @x_velocity = -@x_velocity
    end

    private

    def hit_bottom?
        @y + HEIGHT >= Window.height
    end

      def hit_top?
        @y <= 0
      end

end