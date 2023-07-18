# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :validatable

  include DeviseTokenAuth::Concerns::User

  rolify

  after_create :assign_default_role

  CUSTOMER_ROLE = :customer
  ADMIN_ROLE = :admin

  has_many :user_movie_ratings

  def assign_default_role
    add_role(CUSTOMER_ROLE) if roles.blank?
  end

  def admin?
    has_role? ADMIN_ROLE
  end
end
