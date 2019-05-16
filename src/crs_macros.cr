{% for prefixes in { {"", "", "@"}, {"class_", "self.", "@@"} } %}
    {%
      macro_prefix = prefixes[0].id
      method_prefix = prefixes[1].id
      var_prefix = prefixes[2].id
    %}
    macro {{macro_prefix}}getter(*names, &block)
      \{% if block %}
        \{% if names.size != 1 %}
          \{{ raise "Only one argument can be passed to `getter` with a block" }}
        \{% end %}

        \{% name = names[0] %}

        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name.var.id}} : \{{name.type}}?

          def {{method_prefix}}\{{name.var.id}}
            if (value = {{var_prefix}}\{{name.var.id}}).nil?
              {{var_prefix}}\{{name.var.id}} = \{{yield}}
            else
              value
            end
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}
            if (value = {{var_prefix}}\{{name.id}}).nil?
              {{var_prefix}}\{{name.id}} = \{{yield}}
            else
              value
            end
          end
        \{% end %}
      \{% else %}
        \{% for name in names %}
          \{% if name.is_a?(TypeDeclaration) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.var.id}} : \{{name.type}}
              {{var_prefix}}\{{name.var.id}}
            end
          \{% elsif name.is_a?(Assign) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.target.id}}
              {{var_prefix}}\{{name.target.id}}
            end
          \{% else %}
            def {{method_prefix}}\{{name.id}}
              {{var_prefix}}\{{name.id}}
            end
          \{% end %}
        \{% end %}
      \{% end %}
    end
    macro {{macro_prefix}}getter!(*names)
      \{% for name in names %}
        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name}}?
          \{% name = name.var %}
        \{% end %}

        def {{method_prefix}}\{{name.id}}?
          {{var_prefix}}\{{name.id}}
        end

        def {{method_prefix}}\{{name.id}}
          {{var_prefix}}\{{name.id}}.not_nil!
        end
      \{% end %}
    end
    macro {{macro_prefix}}getter?(*names, &block)
      \{% if block %}
        \{% if names.size != 1 %}
          \{{ raise "Only one argument can be passed to `getter?` with a block" }}
        \{% end %}

        \{% name = names[0] %}

        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name.var.id}} : \{{name.type}}?

          def {{method_prefix}}\{{name.var.id}}?
            if (value = {{var_prefix}}\{{name.var.id}}).nil?
              {{var_prefix}}\{{name.var.id}} = \{{yield}}
            else
              value
            end
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}?
            if (value = {{var_prefix}}\{{name.id}}).nil?
              {{var_prefix}}\{{name.id}} = \{{yield}}
            else
              value
            end
          end
        \{% end %}
      \{% else %}
        \{% for name in names %}
          \{% if name.is_a?(TypeDeclaration) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.var.id}}? : \{{name.type}}
              {{var_prefix}}\{{name.var.id}}
            end
          \{% elsif name.is_a?(Assign) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.target.id}}?
              {{var_prefix}}\{{name.target.id}}
            end
          \{% else %}
            def {{method_prefix}}\{{name.id}}?
              {{var_prefix}}\{{name.id}}
            end
          \{% end %}
        \{% end %}
      \{% end %}
    end
    macro {{macro_prefix}}setter(*names)
      \{% for name in names %}
        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name}}

          def {{method_prefix}}\{{name.var.id}}=({{var_prefix}}\{{name.var.id}} : \{{name.type}})
          end
        \{% elsif name.is_a?(Assign) %}
          {{var_prefix}}\{{name}}

          def {{method_prefix}}\{{name.target.id}}=({{var_prefix}}\{{name.target.id}})
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}=({{var_prefix}}\{{name.id}})
          end
        \{% end %}
      \{% end %}
    end
    macro {{macro_prefix}}property(*names, &block)
      \{% if block %}
        \{% if names.size != 1 %}
          \{{ raise "Only one argument can be passed to `property` with a block" }}
        \{% end %}

        \{% name = names[0] %}

        {{macro_prefix}}setter \{{name}}

        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name.var.id}} : \{{name.type}}?

          def {{method_prefix}}\{{name.var.id}}
            if (value = {{var_prefix}}\{{name.var.id}}).nil?
              {{var_prefix}}\{{name.var.id}} = \{{yield}}
            else
              value
            end
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}
            if (value = {{var_prefix}}\{{name.id}}).nil?
              {{var_prefix}}\{{name.id}} = \{{yield}}
            else
              value
            end
          end
        \{% end %}
      \{% else %}
        \{% for name in names %}
          \{% if name.is_a?(TypeDeclaration) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.var.id}} : \{{name.type}}
              {{var_prefix}}\{{name.var.id}}
            end

            def {{method_prefix}}\{{name.var.id}}=({{var_prefix}}\{{name.var.id}} : \{{name.type}})
            end
          \{% elsif name.is_a?(Assign) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.target.id}}
              {{var_prefix}}\{{name.target.id}}
            end

            def {{method_prefix}}\{{name.target.id}}=({{var_prefix}}\{{name.target.id}})
            end
          \{% else %}
            def {{method_prefix}}\{{name.id}}
              {{var_prefix}}\{{name.id}}
            end

            def {{method_prefix}}\{{name.id}}=({{var_prefix}}\{{name.id}})
            end
          \{% end %}
        \{% end %}
      \{% end %}
    end
    macro {{macro_prefix}}property!(*names)
      {{macro_prefix}}getter! \{{*names}}

      \{% for name in names %}
        \{% if name.is_a?(TypeDeclaration) %}
          def {{method_prefix}}\{{name.var.id}}=({{var_prefix}}\{{name.var.id}} : \{{name.type}})
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}=({{var_prefix}}\{{name.id}})
          end
        \{% end %}
      \{% end %}
    end
    macro {{macro_prefix}}property?(*names, &block)
      \{% if block %}
        \{% if names.size != 1 %}
          \{{ raise "Only one argument can be passed to `property?` with a block" }}
        \{% end %}

        \{% name = names[0] %}

        \{% if name.is_a?(TypeDeclaration) %}
          {{var_prefix}}\{{name.var.id}} : \{{name.type}}?

          def {{method_prefix}}\{{name.var.id}}?
            if (value = {{var_prefix}}\{{name.var.id}}).nil?
              {{var_prefix}}\{{name.var.id}} = \{{yield}}
            else
              value
            end
          end

          def {{method_prefix}}\{{name.var.id}}=({{var_prefix}}\{{name.var.id}} : \{{name.type}})
          end
        \{% else %}
          def {{method_prefix}}\{{name.id}}?
            if (value = {{var_prefix}}\{{name.id}}).nil?
              {{var_prefix}}\{{name.id}} = \{{yield}}
            else
              value
            end
          end

          def {{method_prefix}}\{{name.id}}=({{var_prefix}}\{{name.id}})
          end
        \{% end %}
      \{% else %}
        \{% for name in names %}
          \{% if name.is_a?(TypeDeclaration) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.var.id}}? : \{{name.type}}
              {{var_prefix}}\{{name.var.id}}
            end

            def {{method_prefix}}\{{name.var.id}}=({{var_prefix}}\{{name.var.id}} : \{{name.type}})
            end
          \{% elsif name.is_a?(Assign) %}
            {{var_prefix}}\{{name}}

            def {{method_prefix}}\{{name.target.id}}?
              {{var_prefix}}\{{name.target.id}}
            end

            def {{method_prefix}}\{{name.target.id}}=({{var_prefix}}\{{name.target.id}})
            end
          \{% else %}
            def {{method_prefix}}\{{name.id}}?
              {{var_prefix}}\{{name.id}}
            end

            def {{method_prefix}}\{{name.id}}=({{var_prefix}}\{{name.id}})
            end
          \{% end %}
        \{% end %}
      \{% end %}
    end
  {% end %}
