class ArticlePolicy < ApplicationPolicy
  # %i[index? show?].each do |method|
  #   define_method(method) { user_admin_or_simple? }
  # end

  %i[create? new? edit? update? destroy?].each do |method|
    define_method(method) { user_admin? }
  end

  private

  def user_admin?
    current_user&.admin?
  end

  # def user_admin_or_simple?
  #   user_admin? || current_user&.simple?
  # end
end
