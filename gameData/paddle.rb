require 'ruby2d'

class Paddle
    HEIGHT = 150

    attr_writer :direction
    def initialize(side, speed)
        @speed = speed
        @direction = nil
        @y = 200
        if side == :left
            @x = 40      
        else
           @x = 620 
        end
    end

    def move
        if @direction == :up
            @y = [@y - @speed, 0].max
        elsif @direction == :down
            @y = [@y + @speed, max_y].min
        end
    end

    def draw
        @shape = Rectangle.new(
            x: @x,
            y: @y,
            width: 25,
            height: HEIGHT,
            color: 'white'
        )
    end

    def hit_ball?(ball)
        ball.shape && [[ball.shape.x1, ball.shape.y1], [ball.shape.x2, ball.shape.y2], [ball.shape.x3, ball.shape.y3], [ball.shape.x4, ball.shape.y4]].any? do |coordinates|
            @shape.contains?(coordinates[0], coordinates[1])
        end 
    end

    private

    def max_y
        Window.height - HEIGHT
    end

end