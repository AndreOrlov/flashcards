# app/policies/active_admin/
module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end
    end

    def show?
      case record.name
        when 'Dashboard'
          if user.nil? || !user.has_role?(:admin)
            false
          else
            true
          end
        else
          false
      end
    end
  end
end