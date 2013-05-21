require 'benchmark'

$LOAD_PATH.push(Dir::pwd) 

require 'rubygems'
require 'mime/types'
M1 = MIME
require 'shared-mime-info'
M2 = MIME
require 'ramaze'
# M3 = Ramaze::Tool::MIME

$path = "hoge.rb"
$n = 1000

Benchmark.bmbm do |job|
   job.report("mime/types") {$n.times do; M1::Types.type_for($path); end}
   job.report("shared-mime-info#check") {$n.times do; M2.check($path); end}
   job.report("shared-mime-info#check_globs") {$n.times do; M2.check_globs($path); end}
   job.report("shared-mime-info#check_magics") {$n.times do; M2.check_magics($path); end}
   # job.report("Ramaze::Tool::MIME") {$n.times do; M3.type_for($path); end}
end
