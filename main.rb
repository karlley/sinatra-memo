# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

get '/memos' do
  files = Dir.glob('./data/*.json').sort_by { |file| File.birthtime(file) }.reverse
  @memos = files.map do |file|
    JSON.parse(File.read(file), symbolize_names: true)
  end
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  create_data = { id: SecureRandom.uuid, title: params[:title], content: params[:content] }
  File.open("./data/#{create_data[:id]}.json", 'w') { |file| JSON.dump(create_data, file) }
  redirect '/memos'
  erb :index
end

get '/memos/:id/edit' do |id|
  @memo = JSON.parse(File.read("./data/#{id}.json"), symbolize_names: true)
  erb :edit
end

patch '/memos/:id' do |id|
  update_data = { id: id.to_s, title: params[:title], content: params[:content] }
  File.open("./data/#{id}.json", 'w') { |file| JSON.dump(update_data, file) }
  redirect "/memos/#{id}"
  erb :show
end

get '/memos/:id' do |id|
  @memo = JSON.parse(File.read("./data/#{id}.json"), symbolize_names: true)
  erb :show
end

delete '/memos/:id' do |id|
  File.delete("./data/#{id}.json")
  redirect '/memos'
  erb :index
end
