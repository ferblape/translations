

user1 = User.create(:email => 'matreyes@gmail.com', :password => '1234', :password_confirmation => '1234', :username => 'Matias', :language => 'es')
user2 = User.create(:email => 'otro@gmail.com', :password => '1234', :password_confirmation => '1234', :username => 'Otro', :language => 'en')

key1 = Key.create(:key => 'greeting.welcome')
key2 = Key.create(:key => 'greeting.how_are_you')
key3 = Key.create(:key => 'greeting.bye')

key1.translations.create(:language => 'en', :user => user1, :translation => 'Welcome to Toldo')
key2.translations.create(:language => 'en', :user => user2, :translation => 'How are you?')

key3.translations.create(:language => 'en', :user => user2, :translation => 'Good bye, see you later')
key3.translations.create(:language => 'en', :user => user2, :translation => 'Good bye')

key3.translations.create(:language => 'en', :user => user1, :translation => 'Good bye')

