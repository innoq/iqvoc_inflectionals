module Iqvoc
  module Inflectionals
    
    class BaseFormSanitizer < Iqvoc::Origin::Filters::GenericFilter
      def call(obj, str)
        str = str.gsub(/[,\/\.\[\]]/, '')
    
        run(obj, str)
      end
    end
    
  end
end
