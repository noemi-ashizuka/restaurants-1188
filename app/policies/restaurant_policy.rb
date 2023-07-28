class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # the scope contains the `Restaurant` class that was passed in policy_scope(Restaurant)
      scope.all

      # # Example: only admin users can view all restaurants
      # if user.admin?
      #   scope.all # same as Restaurant.all
      # else
      #   # Only the restaurant that the user owns
      #   scope.where(user: user) # `user` means `current_user` in Pundit
      # end
    end
  end

  # def new?
  #   # You can only see the new form if you're allowed to create
  #   create?
  # end

  def create?
    true
  end

  def show?
    true
  end

  # def edit?
  #   # You can only see the edit form if you're allowed to update
  #   update?
  # end
  
  def update?
    # Only the restaurant owner is allowed to update
    user_is_owner?
  end

  def destroy?
    user_is_owner?

    # Example: only admin users can destroy retaurants:
    # user.admin?
  end

  private

  def user_is_owner?
    # current_user == restaurant.user
    # Except:
    #   current_user => user
    #   restaurant => record
    user == record.user
  end
end
