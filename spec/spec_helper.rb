$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'valuefirst'

def vfirst_config
  Valuefirst::Valuefirst.new(username: "user_name", password: "password").config
end

def load_dtd_from_file file_name
  XML::Dtd.new(File.read("spec/support/dtd/#{file_name}.dtd"))
end