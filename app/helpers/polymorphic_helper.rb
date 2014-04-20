module PolymorphicHelper
  #manage helpers for polymorphic models, and controllers corresponding to those models

   def self.included(mod)
    if mod == ApplicationController 
      mod.extend ClassControllerHelpers
      mod.class_exec { include ControllerHelpers }
    elsif mod.ancestors.include? ActiveRecord::Base
      mod.class_exec { include ModelHelpers }
    end
  end

  private

    module ControllerHelpers
      def find_owner_model_from_params
        params.each do |name, val|
          if name =~ /(.+)_id$/
            if block_given?
              yield $1.modelize, val
            else
              return $1.modelize.find(val)
            end
          end
        end
        nil
      end
    end

    module ModelHelpers
      def owner
        klass = self.attributes[/(.*)_type/]
        id = self.attributes["#{klass.matchdata[1]}_id"]

        klass && id ? klass.modelize.find(id) : nil
      end
    end

    module ClassControllerHelpers
      def inherited(mod)
        rules = { 
          [:find_likeable, :find_owner_model_from_params] => [LikesController,HoverableController]
        }
        rules.each do |meth, c|
          if [c].flatten.include? mod
            mod.class_eval %Q[
              alias :#{meth[0]} :#{meth[1]}
              undef :#{meth[1]}
            ]

          end
        end
      end
    end
end