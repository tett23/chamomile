test_user = User.create(
  username: 'tett23',
  provider: 'twitter',
  uid: 32794163
)

Wiki.create(
  name: 'テスト用',
  slug: 'test',
  description: "test\nfoo\nbar",
  user_id: test_user.id
)
