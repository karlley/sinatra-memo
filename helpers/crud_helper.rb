# frozen_string_literal: true

helpers do
  def set_title
    params[:title].empty? ? 'Untitled' : params[:title]
  end

  def memo_exists?(id)
    all_ids = Dir.glob('./data/*.json').map do |file|
      JSON.parse(File.read(file), symbolize_names: true)[:id]
    end
    all_ids.include?(id)
  end
end
