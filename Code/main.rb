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

Shoes.app title: 'Data encryptor', :width => 450, :height => 350 do
  background gray
  para 'Whence', margin: 10
  @whence = edit_line width: 400, margin: 10
  para 'Where', margin: 10
  @where = edit_line width: 400, margin: 10
  para 'Key', margin: 10
  @key = edit_line width: 400, margin: 10
  @ebutton = button 'Start encrypt', margin: 10
  @dbutton = button 'Start decrypt', margin: 10
  flag = 0
  @ebutton.click do
    flag = 1
    object = get_data
    whence = @whence.text
    where = if @where.text.empty?
              @whence.text + '/encrypt_data'
            else
              @where.text
            end
    object.work_with_directory(whence, where, flag)
  end
  @dbutton.click do
    flag = 0
    object = get_data
    whence = @whence.text
    where = if @where.text.empty?
              @whence.text + '/decrypt_data'
            else
              @where.text
            end
    object.work_with_directory(whence, where, flag)
  end
end
