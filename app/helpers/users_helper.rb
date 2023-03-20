module UsersHelper

    def roles_for_current_user
        if current_user.role.name == "teacher"
            Role.where(name: "student")
        else
            Role.all
        end
    end


end
