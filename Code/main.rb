require 'green_shoes'
require 'pry'
require_relative 'information'

def get_data
  key = if @key.text.empty?
          '2 1 3 0'
        else
          @key.text.split(' ')
        end
  object = Information.new(key)
  object
end

Shoes.app title: 'Encryptor', :width => 450, :height => 350 do
  background gray
  para 'Whence', margin: 10
  @whence = edit_line width: 400, margin: 10
  para 'Where', margin: 10
  @where = edit_line width: 400, margin: 10
  para 'Key', margin: 10
  @key = edit_line width: 400, margin: 10
  @ebutton = button 'Start encrypt', margin: 10
  @dbutton = button 'Start decrypt', margin: 10
  @ebutton.click do
    object = get_data
    whence = @whence.text
    where = if @where.text.empty?
              @whence.text + '/encrypt_data'
            else
              @where.text
            end
    object.work_with_directory(whence, where)
  end
  @dbutton.click do
    object = get_data
    object.decryptor
  end
end
