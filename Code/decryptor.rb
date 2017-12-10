class Decryptor

  attr_accessor :location, :key, :data, :other

  def initialize(location, key, data)
    @location = location
    @key = key
    @data = data
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
    size = @data.size / (max + 1)
    correct_data = Array.new
    correct_data[0] = Array.new(size)
    i = 0
    j = 0
    @data.split('').each do |item|
      if j < size
        correct_data[i][j] = item
      else
        i += 1
        correct_data[i] = Array.new(size)
        j = 0
        correct_data[i][j] = item
      end
      j += 1
    end
    correct_data
  end

  def message_conversion(correct_data, max)
    i = 0
    j = 0
    message = ''
    while j <= correct_data[0].size
      (max + 1).times do |index|
        if @key.include? index.to_s
          message += (correct_data[@key.index(index.to_s)][j]).to_s
        else
          message += (correct_data[max + i][j]).to_s
          i += 1
        end
      end
      i = 0
      j += 1
    end
    message
  end

  def get_message(max)
    correct_data = get_correct_data(max)
    message = message_conversion(correct_data, max)
    message
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