class ActiveRecord::Base

  alias :overwritten_attributes_method :attributes
  def attributes
    result = Hash.new do |hash, key|
      #allow regexp lookup for attributes
      #along with a matchdata helper
      case key
      when Regexp
        singleton_result = nil
        search = hash.find do |k,v|
          singleton_result = k.match key
        end
        r = search[1]
        r.define_singleton_method(:matchdata) do 
          singleton_result
        end
        r
      else
        nil
      end
    end
    result.merge! overwritten_attributes_method
  end

  #undef :new_attributes
end