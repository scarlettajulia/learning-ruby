require 'ruby2d'

t = Time.now

update do
  # Close the window after 5 seconds
  if Time.now - t > 5 then close end
end

while true do 
  set title: "Hello Triangle"

  colors = ['red', 'green', 'blue']

  colors[0], colors[3] = colors[3], colors[0]

  colors = colors.compact
  puts colors

  # Triangle.new(
  #   x1: 320, y1:  50,
  #   x2: 540, y2: 430,
  #   x3: 100, y3: 430,
  #   color: colors
  # )

  # show

  sleep(0.5)
end