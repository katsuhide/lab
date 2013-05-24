# encoding: utf-8

# Noteを取得
body = IO.readlines("C:/Users/miyake0268/Documents/hoge2.txt")
# puts body

# body_ary = body.split(",");
# body_ary = body.split("\n");

# 抜き出したボディからhtmlタグの行を削除
pattern = '<.*?>'
temp = body.reject{ |e| e =~ /#{pattern}/}

# 指定のキーワードが存在するか抜き出す
pattern2 = '(created_datetime|amount)'
temp.each{|data|
	# puts data.scan(/#{pattern2}/)
}

# 指定のキーワードの次の行を抜き出す
puts temp[temp.index("created_datetime\n") + 1]
puts temp[temp.index("amount\n") + 1]

