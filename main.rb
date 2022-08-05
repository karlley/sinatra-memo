# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'cgi'
require 'pg'
require_relative 'helpers/helper'

DB_NAME = 'memo_app'
TABLE_NAME = 'memos'

before do
  @connection = PG::Connection.new(dbname: DB_NAME)
end

not_found do
  erb :not_found
end

get '/memos' do
  @memos = fetch_all_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  create_memo(params[:title], params[:content])
  redirect '/memos'
  erb :index
end

get '/memos/:id/edit' do |id|
  if memo_exists?(id)
    @memo = find_memo(id)
    erb :edit
  else
    erb :not_found
  end
end

patch '/memos/:id' do |id|
  if memo_exists?(id)
    update_memo(id, params[:title], params[:content])
    redirect "/memos/#{id}"
    erb :show
  else
    erb :not_found
  end
end

get '/memos/:id' do |id|
  if memo_exists?(id)
    @memo = find_memo(id)
    erb :show
  else
    erb :not_found
  end
end

delete '/memos/:id' do |id|
  if memo_exists?(id)
    delete_memo(id)
    redirect '/memos'
    erb :index
  else
    erb :not_found
  end
end
