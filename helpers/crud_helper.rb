# frozen_string_literal: true

helpers do
  def memo_exists?(id)
    all_ids = @all_memos.map { |memo| memo['id'] }
    all_ids.include?(id)
  end

  def title_with_default_text
    params[:title].empty? ? 'Untitled' : params[:title]
  end

  def find_memo(id)
    @all_memos.find { |memo| memo['id'] == id }
  end

  def excute_query(sql)
    @connection.exec(sql)
  end
end
