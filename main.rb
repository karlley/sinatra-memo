# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  @memos = File.open('./db/memos.json', 'r') { |memos| JSON.load(memos) }
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memo_data = File.open('./db/memos.json', 'r') { |memos| JSON.load(memos) }
  memo_data['memos'] << { 'id': memo_data['memos'].last['id'].next,
                          'title': params[:title],
                          'content': params[:content] }
  File.open('./db/memos.json', 'w') { |memos| JSON.dump(memo_data, memos) }
  redirect '/'
  erb :index
end

get '/memos/*' do |memo_id|
  @memo = File.open('./db/memos.json', 'r') do |memos|
    memo_data = JSON.load(memos)
    memo_data['memos'][memo_id.to_i.pred]
  end
  erb :show
end
