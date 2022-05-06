module BoothsHelper
  def listening_count_for(booth)
    return booth.operations.select{|x| x.listening_status != nil}.count
  end
end
