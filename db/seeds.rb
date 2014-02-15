test_user = User.create(
  username: 'tett23',
  provider: 'twitter',
  uid: 32794163
)

test_wiki = Wiki.create(
  name: 'テスト用',
  slug: 'test',
  description: "test\nfoo\nbar",
  user_id: test_user.id
)

Page.create(
  name: 'テスト用',
  slug: 'index',
  body: "h1. テスト用\n\n\n",
  wiki_id: test_wiki.id,
  user_id: test_user.id
)
