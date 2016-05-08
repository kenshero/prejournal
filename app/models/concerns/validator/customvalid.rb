module Validator
  module Customvalid
    extend ActiveSupport::Concern
      included do
      def cut_whitespace(val_array)
        val_array.delete_if {|arr| arr == "" }
      end
    end
  end
end