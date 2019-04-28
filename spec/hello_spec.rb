# require_relative "../lib/hello"

require "spec_helper"

RSpec.describe Hello do 
  it "message return hello" do 
    expect(Hello.new.message).to eq "hello"
  end
end

RSpec.describe "四則演算" do 
  it "1+1は2になること" do 
    expect(1+1).to eq 2
  end
  
  #itのaliasメソッド(specify,example)
  # specify(明記する。特定する。)
  # example(実行例)
  
  specify "1+1は2になること" do 
    expect(1+1).to eq 2
  end
  
  example "1+1は2になること" do 
    expect(1+1).to eq 2
  end
  
  
  it "10-1は9になること" do 
    expect(10-1).to eq 9
  end
  
  # 下のように、一つのexampleの中に複数のエクスペクテーションを書くことはできるが、途中でテストが失敗したときに、
  # その先のエクスペクテーションがパスするかしないか予想できないため、
  # 原則「一つのexampleにつき一つのエクスペクテーション」
  
  it "全部できること" do 
    expect(1+2).to eq 3 
    expect(10-4).to eq 6
    expect(4*8).to eq 32
    expect(40/5).to eq 8
  end
end


# ネストしたdescribe

RSpec.describe "四則演算" do 
  
  describe "足し算" do 
    it "1+1は2になること" do 
      expect(1+1).to eq 2
    end
  end
  
  describe "引き算" do 
    it "10-1は9になること" do 
      expect(10-1).to eq 9
    end
  end
end 



# pendingを使ったテストの保留。

# 本来、期待通り正しく動作するはずなのにどうしてもテストがpathしない場合に使う。
# テストを実行してpendingを通り、それ以降でテストが失敗すれば、「pending(保留)」としてマークされる。
# テストが最後までpathした場合は、「pendingする理由がありません」と、テスト失敗になってしまう。

RSpec.describe "繊細なクラス" do 
  it "繊細なテスト" do 
    expect(1+2).to eq 3 
  end
  
  context "Hello#message" do 
    hello = Hello.new
    it "繊細なテスト2"do 
      # pending "この場合はテストがpathするのでテスト失敗となる。"
      expect(hello.message).to eq "hello"
    end
    
    it "繊細なテスト3" do 
      pending "この先はなぜかテストが失敗するので後で直す。(pendingする)"
      expect(hello.message).to eq "hi"
    end
    
  end
end


# skipを使ったテストの中止。
# skipから下のexampleは強制的に保留(pending)に入る。

RSpec.describe "何らかの理由で実行したくないクラス" do 
  it "実行したくないテスト" do 
    expect(1+2).to eq 3
    
    skip "上までは実行するがこれから下は実行されない(pendingに入る。)"
    expect(1+3).to eq 10
  end
end