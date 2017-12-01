require 'green_shoes'

Shoes.app( :width => 500, :height => 250) do
  @whence = edit_line width: 400, margin: 10
  @fbutton = button 'Browse'
  @where = edit_line width: 400, margin: 10
  @fbutton = button 'Browse'
  @phrace = edit_line width: 400, margin: 10

end