test_user = User.seed do |s|
  s.username = 'tett23',
  s.provider = 'twitter',
  s.uid = 32794163
end.first

test_wiki = Wiki.seed do |s|
  s.name = 'テスト用',
  s.slug = 'test',
  s.description = "test\nfoo\nbar",
  s.user_id = test_user.id
end.first

p test_wiki.id
Page.seed do |s|
  s.name = 'テスト用'
  s.slug = 'index'
  s.body = "h1. テスト用\n\n\nテスト"
  s.wiki_id = test_wiki.id
  s.user_id = test_user.id
end

Page.seed do |s|
  s.name = 'index'
  s.slug = 'index_'
  s.body = '同名のslugが存在する'
  s.wiki_id = test_wiki.id
  s.user_id = test_user.id
end

Page.seed do |s|
  s.name = 'slugなし'
  s.slug = nil
  s.body = 'foo'
  s.wiki_id = test_wiki.id
  s.user_id = test_user.id
end
