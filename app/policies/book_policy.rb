class BookPolicy < ApplicationPolicy
  def create?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
