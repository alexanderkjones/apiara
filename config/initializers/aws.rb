AWS.config({
    :access_key_id => 'AKIAIGCGEKV7NX5VQDGA',
    :secret_access_key => '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',
  })

AWS::Record.domain_prefix = ["apiara_", Rails.env, "_"].join("")
AWS::Record.table_prefix = ["apiara_", Rails.env, "_"].join("")

module AWS
  module Record
    module AbstractBase
      module InstanceMethods
 
        # Allow the user to override the ID
        def populate_id
          @_id = @_data['id'] || UUIDTools::UUID.random_create.to_s.downcase
        end
      end
    end
  end
end
