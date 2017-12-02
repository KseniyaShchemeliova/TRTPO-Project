require 'green_shoes'
require 'pry'
require_relative 'information'

def get_data
  whence = @whence.text
  where = if @where.text
             @where.text
           else
             @whence.text + 'encrypt_data'
           end
  object = Information.new(whence, where)
  object
end

Shoes.app title: 'Encryptor', :width => 450, :height => 350 do
  background gray
  para 'Whence', margin: 10
  @whence = edit_line width: 400, margin: 10
  para 'Where', margin: 10
  @where = edit_line width: 400, margin: 10
  para 'Key', margin: 10
  @phrace = edit_line width: 400, margin: 10
  @ebutton = button 'Start encrypt', margin: 10
  @dbutton = button 'Start decrypt', margin: 10
  @ebutton.click do
    object = get_data
    object.encrypt_data
  end
  @dbutton.click do
    object = get_data
    object.decrypt_data
  end
end
