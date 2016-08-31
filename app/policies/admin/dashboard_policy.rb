class DashboardPolicy < ApplicationPolicy
  def dashboard?
    true
  end
  def index?
    true
  end
  def new?
    true
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

#TODO Оба класса не работают, доступ к activeedmin все равно есть не авторизированному юзеру. Это разные варианты