class BaseStore
  attr_accessor :user

  def initialize(user = nil)
    @user = user
  end
end
