# frozen_string_literal: true

helpers do
  def fetch_all_memos
    @connection.exec("SELECT * FROM #{TABLE_NAME}")
  end

  def memo_exists?(id)
    all_memos = fetch_all_memos
    all_ids = all_memos.map { |memo| memo['id'] }
    all_ids.include?(id)
  end

  def find_memo(id)
    @connection.exec("SELECT * FROM #{TABLE_NAME} WHERE id = '#{id}'").first
  end

  def title_with_default_text(title)
    title.empty? ? 'Untitled' : title
  end

  def create_memo(title, content)
    @connection.exec(<<~SQL)
      INSERT INTO #{TABLE_NAME} (id, title, content)
      VALUES ('#{SecureRandom.uuid}', '#{title_with_default_text(title)}', '#{content}')
    SQL
  end

  def update_memo(id, title, content)
    @connection.exec(<<~SQL)
      UPDATE memos
      SET title = '#{title_with_default_text(title)}', content = '#{content}'
      WHERE id = '#{id}'
    SQL
  end

  def delete_memo(id)
    @connection.exec("DELETE FROM #{TABLE_NAME} WHERE id = '#{id}'")
  end
end
