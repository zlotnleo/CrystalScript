class CrystalScript
  def set_instance
    @nto.in_any_order do |named_type|
      if named_type.is_a? NamedType || named_type.is_a? GenericInstanceType
        @output << Crustache.render Templates::HAS_INSTANCE, {
          "path" => CrystalScript.to_str_path(named_type).map { |name| {"Type" => name} },
          "generic_instances" => if named_type.is_a? GenericType
            @nto.get_all_instances(named_type).map do |instance_type|
              {
                "path" => CrystalScript.to_str_path(instance_type).map do |name|
                  {"Type" => name}
                end
              }
            end
          else
            false
          end
        }
      else
        @output << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
      end
    end
  end
end
