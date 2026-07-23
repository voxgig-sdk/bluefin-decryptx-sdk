# BluefinDecryptx SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module BluefinDecryptxFeatures
  def self.make_feature(name)
    case name
    when "base"
      BluefinDecryptxBaseFeature.new
    when "test"
      BluefinDecryptxTestFeature.new
    else
      BluefinDecryptxBaseFeature.new
    end
  end
end
