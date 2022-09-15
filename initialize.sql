CREATE TABLE memos (id CHAR(36) NOT NULL, title VARCHAR(100) NOT NULL, content VARCHAR(255), PRIMARY KEY (id));
INSERT INTO memos (id, title, content) VALUES ('bc9db029-408a-4f5b-bf49-5e5af9581532', 'memo1', 'this is memo1');
INSERT INTO memos (id, title, content) VALUES ('c9e67c66-4219-411f-ab7f-625a7e5e4ceb', 'memo2', 'this is memo2');