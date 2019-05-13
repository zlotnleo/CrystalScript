class CrystalScript
  def apply_extend
    @nto.in_any_order do |named_type|
      case named_type
      when NamedType | GenericInstanceType
        extended_modules = named_type.metaclass.parents.try &.select { |parent| parent.module? }
        unless extended_modules.nil? || extended_modules.empty?
          @output << Crustache.render Templates::APPLY_EXTEND, {
            "path" => CrystalScript.to_str_path(named_type).map { |t|
              { "Type" => t }
            },
            "extended_modules" => extended_modules.map { |mod|
              {
                "path" => CrystalScript.to_str_path(mod).map { |t|
                  { "Type" => t }
                }
              }
            }
          }
        end
      else
        @output << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
      end
    end
  end
end
