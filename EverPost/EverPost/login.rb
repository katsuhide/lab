# encoding: utf-8
require 'evernote_oauth'

client = EvernoteOAuth::Client.new(
consumer_key: "katzlifehack",
consumer_secret: "9490d8896d0bb1a3",
sandbox: [true]
)

callback_url = ""
# request_token = client.request_token(:oauth_callback => 'YOUR CALLBACK URL')
request_token = client.request_token(:oauth_callback => "callback_url")

puts callback_url

## ログイン& 認証ページを開く
system "open #{request_token.authorize_url}"
sleep 15

puts callback_url

p access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])

token = access_token.token
client = EvernoteOAuth::Client.new(token: token)
note_store = client.note_store
puts notebooks = note_store.listNotebooks(token)
