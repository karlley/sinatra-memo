# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'cgi'
require 'pg'
require_relative 'helpers/helper'

DB_NAME = 'memo_app'

before do
  @connection = PG::Connection.new(dbname: DB_NAME)
  @all_memos = excute_query('SELECT * FROM memos')
end

not_found do
  erb :not_found
end

get '/memos' do
  @memos = @all_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  excute_query(<<~SQL)
    INSERT INTO memos (id, title, content)
    VALUES ('#{SecureRandom.uuid}', '#{title_with_default_text}', '#{params[:content]}')
  SQL
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
    excute_query(<<~SQL)
      UPDATE memos
      SET title = '#{title_with_default_text}', content = '#{params[:content]}'
      WHERE id = '#{id}'
    SQL
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
    excute_query("DELETE FROM memos WHERE id = '#{id}'")
    redirect '/memos'
    erb :index
  else
    erb :not_found
  end
end
