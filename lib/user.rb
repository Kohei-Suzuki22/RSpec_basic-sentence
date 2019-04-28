class User 
  
  def initialize(name:,age:)
    @name = name 
    @age = age 
  end
  
  def greet 
    if child? 
      "ぼくは#{@name}だよ。"
    else 
      "僕は#{@name}です。"
    end
  end
  
  def child? 
    @age <= 12
  end
end