require_relative 'decryptor'
require_relative 'encryptor'

class Information
  attr_accessor :data, :key

  def initialize(key)
    @key = key
  end

  def found_directory(location)
    directory = []
    Dir.chdir(location)
    files = Dir.entries(location)
    files.delete('..')
    files.delete('.')
    files.each do |file|
      next unless File.directory? file
      directory << file
    end
    directory
  end

  def get_files(location, directory)
    @data = Dir.entries(location)
    @data.delete('..')
    @data.delete('.')
    directory.each do |dir|
      @data.delete(dir)
    end
  end

  def new_dir(location)
    unless File.exist?(location)
      Dir.mkdir(location)
    end
    Dir.chdir(location)
  end

  def work_with_directory(location, where, flag)
    new_dir(where)
    directory = found_directory(location)
    if directory.size != 0
      directory.each do |dir|
        work_with_directory(location + '/' + dir, where + '/' + dir, flag)
      end
    end
    get_files(location, directory)
    @data.each do |file_name|
      Dir.chdir(location)
      file = open(file_name, 'rb')
      content = file.read
      file.close
      Dir.chdir(where)
      decryptor = if flag.zero?
                    Decryptor.new(where, @key, content)
                  else
                    Encryptor.new(where, @key, content)
                  end
      decryptor.copy_data(file_name)
    end
  end

end