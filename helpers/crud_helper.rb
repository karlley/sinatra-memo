# frozen_string_literal: true

helpers do
  def id_exists?(id)
    all_files = Dir.glob('./data/*.json')
    all_memos = all_files.map do |file|
      JSON.parse(File.read(file), symbolize_names: true)
    end
    all_memos_id = all_memos.map do |memo|
      memo[:id]
    end
    all_memos_id.include?(id)
  end
end
