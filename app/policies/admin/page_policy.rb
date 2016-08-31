# module ActiveAdmin
#   class PagePolicy < ApplicationPolicy
#     class Scope < Struct.new(:user, :scope)
#       def resolve
#         scope
#       end
#     end
#     def index?
#       true
#     end
#
#     def show?
#       true
#     end
#   end
# end

class ActiveAdmin::PagePolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    case record.name
      when 'Dashboard'
        true
      else
        @user.admin?
    end
  end
end


class Dashboard < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    case subject
      when ActiveAdmin::Page
        action == :read && subject.name == "Dashboard"
      else
        false
    end
  end
  def new?
    create?
  end
end