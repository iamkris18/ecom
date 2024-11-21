class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new # Guest user
      if user.admin?
        can :manage, :all  # Admin can manage everything
      else
        can :read, :all    # Non-admin users can read everything
      end
    end
  end
  