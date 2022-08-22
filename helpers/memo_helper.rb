# frozen_string_literal: true

DB_NAME = 'memo_app'
TABLE_NAME = 'memos'
CONNECTION = PG::Connection.new(dbname: DB_NAME)

# DB接続、CRUD処理のヘルパー
module MemoHelper
  def excute(query, params = [])
    CONNECTION.exec_params(query, params)
  end

  def title_with_default_text(title)
    title.empty? ? 'Untitled' : title
  end

  def memo_exists?(id, all_memos)
    all_ids = all_memos.map { |memo| memo['id'] }
    all_ids.include?(id)
  end

  def fetch_all_memos
    query = "SELECT * FROM #{TABLE_NAME}"
    excute(query)
  end

  def find_memo(id, all_memos)
    all_memos.find do |memo|
      memo['id'] == id
    end
  end

  def create_memo(title, content)
    query = "INSERT INTO #{TABLE_NAME} (id, title, content) VALUES ($1, $2, $3)"
    params = %W[
      #{SecureRandom.uuid}
      #{title_with_default_text(title)}
      #{content}
    ]
    excute(query, params)
  end

  def update_memo(id, title, content)
    query = "UPDATE #{TABLE_NAME} SET title = $2, content = $3 WHERE id = $1"
    params = %W[
      #{id}
      #{title_with_default_text(title)}
      #{content}
    ]
    excute(query, params)
  end

  def delete_memo(id)
    query = "DELETE FROM #{TABLE_NAME} WHERE id = $1"
    params = [id]
    excute(query, params)
  end
end
