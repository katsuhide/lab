# encoding: utf-8
require 'rubygems'
require 'mimemagic'

# path = "mime.rb"
path = "/Users/AirMyac/Desktop/hoge.txt"

# 拡張子から判定する
puts MimeMagic.by_extension('html')

# パスから判定する
puts MimeMagic.by_path(path)

# ファイルの中身から判定する
puts MimeMagic.by_magic(File.open(path))

