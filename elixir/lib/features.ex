# BluefinDecryptx SDK feature factory

defmodule BluefinDecryptx.Features do
  def make_feature(name) do
    case name do
      "test" -> BluefinDecryptx.Feature.Test.new()
      _ -> BluefinDecryptx.Feature.new()
    end
  end
end
