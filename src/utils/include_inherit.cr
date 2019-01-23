class CrystalScript::CodeGen
  def include_inherit
    String.build do |str|
      @ntv.traverse_tree do |cur_type|
        # TODO including types
        # type.including_types
        # Returns the list of types that include the type
        # this method is called on

        # TODO extend all subclasses with current type's prototype
        cur_type.subclasses.each do |subclass|

        end
      end
    end
  end
end
