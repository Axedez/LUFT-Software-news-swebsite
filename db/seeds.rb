# Admin seed

User.create(username: 'admin', role: :admin, password: 'admin123', email: 'admin@mail.com')

# Other data

FactoryBot.create_list(:user, 2, role: :admin)
FactoryBot.create_list(:user, 20, role: :simple)

User.admin.all.each do |admin|
  FactoryBot.create_list(:article, 10, :with_image, user: admin)
end
