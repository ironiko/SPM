class Ability
  include CanCan::Ability

    def initialize(user)

        user ||= user.new #guest user

        if user.role == "admin"
            can :manage, :all
        elsif user.role == "alumno"
            can :read, Trivia
            can [:read, :create], Pregunta
        elsif user.role == "profesor"
            can [:read, :create], Respuesta
            can :read, clase
        end
    end
end
