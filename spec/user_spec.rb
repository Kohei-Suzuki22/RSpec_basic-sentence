require_relative "../lib/user"

require "spec_helper"

RSpec.describe User do 
  describe "#greet" do 
    
    it "12歳以下の場合、ひらがなで答えること" do 
      user = User.new(name:"たろう",age:12)
      expect(user.greet).to eq "ぼくはたろうだよ。"
    end
    
    it "13歳以上の場合、漢字で答えること" do 
      user = User.new(name:"たろう",age:13)
      expect(user.greet).to eq "僕はたろうです。"
    end
    
  end
end