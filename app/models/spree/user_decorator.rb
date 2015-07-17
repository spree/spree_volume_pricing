Spree.user_class.class_eval do

  def resolve_role

    if self.has_spree_role? Spree::Config.wholesale_role.to_sym
      return Spree::Role.find_by name: Spree::Config.wholesale_role
    else
      return Spree::Role.find_by name: 'user'
    end
  end
end
