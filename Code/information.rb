require_relative 'decryptor'
require_relative 'encryptor'
require 'pry'

class Information
  attr_accessor :data, :location, :way

  def initialize(location, way)
    @location = location
    @way = way
    @data = Dir.entries(@location)
    @data.delete(@data.last)
    @data.delete(@data.last)
    p @data

  end

  def encrypt_data
    encryptor = Encryptor.new()
    encryptor.encrypt_data
  end

  def decrypt_data
    decryptor = Decryptor.new()
    decryptor.decrypt_data
  end
end