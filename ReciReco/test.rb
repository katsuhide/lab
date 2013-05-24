# encoding:utf-8
str2 = '<table style="width: 100%; font-weight: bold; margin-bottom: 20px; border-collapse: collapse;"><tr><td colspan="1" rowspan="1" style="width: 80px; padding: 10px; border-bottom: solid 1px #ddd;">DATE_TIME</td><td colspan="1" rowspan="1" style="padding: 10px; border-bottom: solid 1px #ddd;">2013/02/13 21:27</td></tr><tr><td colspan="1" rowspan="1" style="width: 80px; padding: 10px; border-bottom: solid 1px #ddd;">TEL_NO</td><td colspan="1" rowspan="1" style="padding: 10px; border-bottom: solid 1px #ddd;">0356147718</td></tr><tr><td colspan="1" rowspan="1" style="width: 80px; padding: 10px; border-bottom: solid 1px #ddd;">AMOUNT</td><td colspan="1" rowspan="1" style="padding: 10px; border-bottom: solid 1px #ddd;">짜1,162</td></tr><tr><td colspan="1" rowspan="1" style="width: 80px; padding: 10px; border-bottom: solid 1px #ddd;">TAG</td><td colspan="1" rowspan="1" style="padding: 10px; border-bottom: solid 1px #ddd;"> </td></tr></table>
'
array = str2.split(/>/)

WORD = '(DATE_TIME|AMOUNT)'

count = 0
array.each{|data|
	tmp = data.scan(/#{WORD}/)
	if tmp.size == 0
	 else
	 	str = array[count + 2]
	 	puts str[0..str.size - 5]
	 end
 	count += 1
}

