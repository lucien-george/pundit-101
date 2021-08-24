class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all # => Restaurant.all
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  # def new?
  #   true
  # end

  def create?
    true
  end

  def show?
    true
  end

  # def edit?
  #   # current_user => user
  #   # @restaurant => record
  #   restaurant_owner?
  # end

  def update?
    restaurant_owner_or_admin?
  end

  def destroy?
    restaurant_owner_or_admin?
  end

  private

  def restaurant_owner_or_admin?
    user == record.user || user.admin? # => current_user == @restaurant.user
  end
end
