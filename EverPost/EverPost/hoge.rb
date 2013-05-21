# encoding: utf-8
require 'rubygems'

filename = '/Users/AirMyac/Desktop/memo.pdf'
$mime_type = ""

def hoge(arg)
	puts RUBY_VERSION
	puts arg
end

hoge(ARGV[0])

hashHex = "AAAAA"
content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>This is MacRuby's Test!!<br/>
  <en-media type="#{$mime_type}" hash="#{hashHex}"/>
</en-note>
EOF

puts content