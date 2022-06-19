# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require_relative 'helpers/crud_helper'

not_found do
  erb :not_found
end

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
  create_data = { id: SecureRandom.uuid, title: set_title, content: params[:content] }
  File.open("./data/#{create_data[:id]}.json", 'w') { |file| JSON.dump(create_data, file) }
  redirect '/memos'
  erb :index
end

get '/memos/:id/edit' do |id|
  if memo_exists?(id)
    @memo = get_memo(id)
    erb :edit
  else
    erb :not_found
  end
end

patch '/memos/:id' do |id|
  update_data = { id: id.to_s, title: set_title, content: params[:content] }
  File.open("./data/#{id}.json", 'w') { |file| JSON.dump(update_data, file) }
  redirect "/memos/#{id}"
  erb :show
end

get '/memos/:id' do |id|
  if memo_exists?(id)
    @memo = get_memo(id)
    erb :show
  else
    erb :not_found
  end
end

delete '/memos/:id' do |id|
  File.delete("./data/#{id}.json")
  redirect '/memos'
  erb :index
end
