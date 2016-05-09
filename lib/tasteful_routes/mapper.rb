module ActionDispatch::Routing
  class Mapper
    module Resources
      silence_warnings do
        RESOURCE_OPTIONS.push :authenticatable
      end
    end

    module TastefulResources
      class TastefulResource < ActionDispatch::Routing::Mapper::Resource
        def member_scope
          options[:authenticatable] ? "#{path.singularize}(/:id)" : "#{path.singularize}/:id"
        end

        def new_scope(new_path)
          "#{path.singularize}/#{new_path}"
        end

        def nested_scope
          options[:authenticatable] ? "#{path.singularize}(/:#{singular}_id)" : "#{path.singularize}/:#{singular}_id"
        end
      end

      def tasteful_resources(*resources, &block)
        options = resources.extract_options!

        if apply_common_behavior_for(:tasteful_resources, resources, options, &block)
          return self
        end

        resource_scope(:resource, TastefulResource.new(resources.pop, options)) do
          yield if block_given?

          collection do
            get  :index if parent_resource.actions.include?(:index)
            post :create if parent_resource.actions.include?(:create)
          end

          new do
            get :new
          end if parent_resource.actions.include?(:new)

          member do
            get    :edit if parent_resource.actions.include?(:edit)
            get    :show if parent_resource.actions.include?(:show)
            put    :update if parent_resource.actions.include?(:update)
            delete :destroy if parent_resource.actions.include?(:destroy)
          end
        end

        self
      end

    end
    include TastefulResources
  end
end
