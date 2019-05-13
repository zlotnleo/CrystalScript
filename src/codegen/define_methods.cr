# class CrystalScript
#   def define_instance_methods(named_type : NamedType)
#     type_name = CrystalScript.to_js_name(named_type)
#     if named_type.is_a? DefInstanceContainer
#       named_type.def_instances.each do |def_instance_key, def|
#       end
#     end
#     # String.build do |str|
#     #   unless (defs = named_type.defs).nil?
#     #     define_methods str, type_name, defs, instance: true
#     #   end
#     # end
#   end

#   def define_class_methods(named_type : NamedType)
#     type_name = CrystalScript.to_js_name(named_type)
#     String.build do |str|
#       if named_type.is_a? ClassType
#         str << Crustache.render Templates::CLASS_NEW, {
#           "TypeName" => type_name,
#           "has_init" => !(defs = named_type.defs).nil? && defs.has_key? "initialize"
#         }
#       end
#       unless (defs = named_type.metaclass.defs).nil?
#         defs.delete("allocate")
#         defs.delete("new")
#         define_methods str, type_name, defs, instance: false
#       end
#     end
#   end

#   private def define_methods(str, name, defs, *, instance)
#     defs.each do |method_name, method_defs|
#       model = {
#         "is_instance" => instance,
#         "TypeName" => name,
#         "MethodName" => method_name,
#         "funcs" => method_defs.map do |method_def|
#           begin
#             arg_names = method_def.def.args.map &.name
#             unless (barg = method_def.def.block_arg).nil?
#               arg_names << barg.name
#             end
#             {
#               "MinArgs" => method_def.min_size.to_s,
#               "MaxArgs" => method_def.max_size.to_s,
#               "HasBlock" => method_def.yields ? "true" : "false",
#               "MethodBody" => ExpressionGen.new(arg_names).generate(method_def.def.body),
#               "func_args" => method_def.def.args.select do |arg|
#                 !arg.name.empty?
#               end.map do |arg|
#                 {
#                   "ArgName" => CrystalScript.safe_var_name(arg.name),
#                   "has_default" => begin
#                     if (default = arg.default_value).nil?
#                       false
#                     else
#                       {
#                         "DefaultVal" => "undefined /* PlaceHolder */" # generate(default)
#                       }
#                     end
#                   end
#                 }
#               end,
#               "has_external_names" => begin
#                 different_name_args = method_def.def.args.select do |arg|
#                   arg.external_name != arg.name
#                 end
#                 if different_name_args.empty?
#                   false
#                 else
#                   {
#                     "external_names" => different_name_args.map do |arg|
#                       {
#                         "ExternalName" => arg.external_name,
#                         "InternalName" => arg.name
#                       }
#                     end
#                   }
#                 end
#               end
#             }
#           rescue ex : ExpressionGen::UnsafeMethodError
#             CrystalScript.logger.warn ex.message
#             {
#               "MinArgs" => "-1",
#               "MaxArgs" => "-1",
#               "HasBlock" => "false",
#               "MethodBody" => "",
#               "func_args" => false,
#               "has_external_names" => false
#             }
#           end
#         end
#       }

#       str << Crustache.render Templates::DEFINE_METHODS, model
#     end
#   end
# end

class CrystalScript
  def define_instance_methods(named_type)
    String.build do |str|
      if named_type.is_a? DefInstanceContainer
        initialised_def_names = Set(String).new
        named_type.def_instances.values.each do |a_def|
          if initialised_def_names.add? a_def.name
            str << Crustache.render Templates::INIT_INSTANCE_METHOD, {
              "MethodName" => CrystalScript.get_method(a_def, include_args: false, include_class: true)
            }
          end

          str << Crustache.render Templates::INSTANCE_METHOD, {
            "MethodName" => CrystalScript.get_method(a_def, include_args: true, include_class: true),
            "Body" => ExpressionGen.new.generate(a_def.body)
          }
        end
      end
    end
  end

  def define_class_methods(named_type)
    String.build do |str|
      if (metaclass = named_type.metaclass).is_a? DefInstanceContainer
        CrystalScript.logger.info named_type
        metaclass.def_instances.each do |def_instance_key, a_def|
          CrystalScript.logger.info "    class #{a_def.name}"
          CrystalScript.logger.info def_instance_key
          CrystalScript.logger.info a_def
        end
        CrystalScript.logger.info "\n"
      end
    end
  end
end
