# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/memos' do
  @memos = JSON.parse(File.read('./db/memos.json'), symbolize_names: true)
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
  redirect '/memos'
  erb :index
end

get '/memos/*/edit' do |memo_id|
  memos = JSON.parse(File.read('./db/memos.json'), symbolize_names: true)
  @memo = memos[:memos][memo_id.to_i.pred]
  erb :edit
end

patch '/memos/*' do |memo_id|
  memo_data = JSON.parse(File.read('./db/memos.json'), symbolize_names: true)
  update_data = { 'id': memo_id.to_i,
                  'title': params[:title],
                  'content': params[:content] }
  memo_data[:memos][memo_id.to_i.pred].update(update_data)
  File.open('./db/memos.json', 'w') { |memos| JSON.dump(memo_data, memos) }
  redirect "/memos/#{memo_id}"
  erb :show
end

get '/memos/*' do |memo_id|
  @memo = File.open('./db/memos.json', 'r') do |memos|
    memo_data = JSON.load(memos)
    memo_data['memos'][memo_id.to_i.pred]
  end
  erb :show
end
