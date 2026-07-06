# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    @user
  end

  def create?
    @user
  end

  def show?
    @user&.admin? || @record.published? || @record.user_id == @user&.id
  end

  def edit?
    @record.user_id == @user&.id || @user&.admin?
  end

  def update?
    @record.user_id == @user&.id || @user&.admin?
  end

  def to_moderate?
    @record.user_id == @user&.id || @user&.admin?
  end

  def archive?
    @record.user_id == @user&.id || @user&.admin?
  end
end
