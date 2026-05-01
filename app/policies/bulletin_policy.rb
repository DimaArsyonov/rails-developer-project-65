class BulletinPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end

  def index?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def show?
    true
  end

  def edit?
    bulletin.user_id == user.id
  end

  def update?
    bulletin.user_id == user.id
  end

  def publish?
    user.admin?
  end

  def reject?
    user.admin?
  end

  def to_moderate?
    user.admin?
  end

  def archive?
    user.admin?
  end
end
