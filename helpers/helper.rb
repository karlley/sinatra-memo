# frozen_string_literal: true

DB_NAME = 'memo_app'
TABLE_NAME = 'memos'

helpers do
  def excute(query)
    connection = PG::Connection.new(dbname: DB_NAME)
    connection.exec(query)
  end

  def fetch_all_memos
    excute("SELECT * FROM #{TABLE_NAME}")
  end

  def memo_exists?(id, all_memos)
    all_ids = all_memos.map { |memo| memo['id'] }
    all_ids.include?(id)
  end

  def find_memo(id, all_memos)
    all_memos.map do |memo|
      memo if memo['id'] == id
    end.compact.first
  end

  def title_with_default_text(title)
    title.empty? ? 'Untitled' : title
  end

  def create_memo(title, content)
    excute(<<~SQL)
      INSERT INTO #{TABLE_NAME} (id, title, content)
      VALUES ('#{SecureRandom.uuid}', '#{title_with_default_text(title)}', '#{content}')
    SQL
  end

  def update_memo(id, title, content)
    excute(<<~SQL)
      UPDATE #{TABLE_NAME}
      SET title = '#{title_with_default_text(title)}', content = '#{content}'
      WHERE id = '#{id}'
    SQL
  end

  def delete_memo(id)
    excute("DELETE FROM #{TABLE_NAME} WHERE id = '#{id}'")
  end
end
