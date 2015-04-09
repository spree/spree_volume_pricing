Spree.user_class.class_eval do
  

  def resolve_role

    if self.has_spree_role? :wholesale
      return Spree::Role.find_by name: 'wholesale'
    else
      return Spree::Role.find_by name: 'user'
    end

  end
end