class Database
  def self.add_user(user_name)
    User.create name: user_name
  end
end
