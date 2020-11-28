require 'ruby2d'

require_relative 'ball.rb'

class Paddle
    HEIGHT = 150

    attr_writer :direction
    attr_reader :side

    def initialize(side, movement_speed)
        @side = side
        @movement_speed = movement_speed
        @direction = nil
        @y = 200
        if side == :left
            @x = 40      
        else
           @x = 600 
        end
    end

    def move
        if @direction == :up
            @y = [@y - @movement_speed, 0].max
        elsif @direction == :down
            @y = [@y + @movement_speed, max_y].min
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

  def track_ball(ball)
    if ball.y_middle > y_middle
      @y += @movement_speed
    elsif ball.y_middle < y_middle
      @y -= @movement_speed
    end
  end

    def y1
        @shape.y1
    end

    private

    def y_middle
        height = @y + (HEIGHT / 2)
        return height
    end

    def max_y
        max = Window.height - HEIGHT
        return max
    end

end