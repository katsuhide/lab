require 'yaml'

filename = "evernote.yaml"
data = YAML.load_file(filename)
puts data
puts data.fetch('authToken')
