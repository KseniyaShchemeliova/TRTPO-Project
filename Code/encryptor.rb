class Encryptor

  attr_accessor :location, :key, :data, :other

  def initialize(location, key, data)
    @location = location
    @key = key
    @data = data
    @data = @data.delete(data.split('').last)
    @other = []
  end

  def copy_data(file_name)
    max = found_max
    message = get_message(max.to_i)
    file = open(file_name, 'wb')
    file.write(message)
    file.close
  end

  def get_correct_data(max)
    correct_data = Array.new
    correct_data[0] = Array.new(max)
    i = 0
    j = 0
    @data.split('').each do |item|
      if j <= max
        correct_data[i][j] = item
      else
        i += 1
        correct_data[i] = Array.new(max)
        j = 0
        correct_data[i][j] = item
      end
      j += 1
    end
    correct_data
  end

  def get_key_message(correct_data, max_j)
    i = 0
    j = 0
    max_i = correct_data.size
    message = Array.new(max_j)
    message[i] = Array.new(max_i)
    @key.each do |index|
      @other << index.to_i
      while j < max_i
        message[i][j] = correct_data[j][index.to_i]
        j += 1
      end
      i += 1
      j = 0
      message[i] = Array.new(max_i)
    end
    message
  end

  def get_other_message(max_j, message, correct_data)
    @other = found_other_index(max_j + 1)
    max_i = correct_data.size
    i = 0
    while !message[i].nil?
      i += 1
    end
    i -= 1
    j = 0
    message[i] = Array.new(max_i)
    @other.each do |index|
      while j < max_i
        message[i][j] = correct_data[j][index]
        j += 1
      end
      i += 1
      j = 0
      message[i] = Array.new(max_i)
    end
    message
  end

  def get_message(max)
    correct_data = get_correct_data(max)
    message = get_key_message(correct_data, max)
    message = get_other_message(max, message, correct_data)
    message = get_string(message)
    message
  end

  def get_string(message)
    line = ''
    message.delete(message.last)
    message.each do |item|
      item.each do |letter|
        letter = ' ' if letter.nil?
        line += letter
      end
    end
    line
  end

  def found_other_index(max)
    combo = Array.new
    max.times do |item|
      next if @other.include? item
      combo << item
    end
    combo
  end

  def found_max
    flag = true
    while flag
      max = @key.max
      if max.to_i > @data.size
        @key.delete(max)
      else
        flag = false
      end
    end
    max
  end

end