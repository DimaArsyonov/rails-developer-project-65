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
    @user&.admin? || @record.published? || author?
  end

  def edit?
    author? || @user&.admin?
  end

  def update?
    author? || @user&.admin?
  end

  def to_moderate?
    author? || @user&.admin?
  end

  def archive?
    author? || @user&.admin?
  end

  private

  def author?
    @record.user_id == @user&.id
  end
end
