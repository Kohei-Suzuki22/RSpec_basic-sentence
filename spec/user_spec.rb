require_relative "../lib/user"

require "spec_helper"

# describeには describe User のように、文字列ではなくクラスを渡すこともできる。
# describe "#greet"のように書くことで、「インスタンスメソッドのgreetメソッドをテストするよ」と意味づけ。
RSpec.describe User do 
  describe "#greet" do 
    
    #beforeをつかってDRY。このとき、beforeとcontextの中でスコープが異なるため、インスタンス変数を使う。
    #beforeをネストすると親から順に呼ばれる.
    before do 
      @params = {name:"たろう"}
    end
    
    # contextで条件別にグループ化をする。(12歳以下 or 13歳以上)
    context "12歳以下の場合" do 
      before do 
        @params.merge!(age:12)
      end
      it "ひらがなで答えること" do 
        user = User.new(@params)
        expect(user.greet).to eq "ぼくはたろうだよ。"
      end
    end
    
    context "13歳以上の場合" do 
      before do 
        @params.merge!(age:13)
      end
      it "漢字で答えること" do 
        user = User.new(@params)
        expect(user.greet).to eq "僕はたろうです。"
      end
    end
    
  end
end