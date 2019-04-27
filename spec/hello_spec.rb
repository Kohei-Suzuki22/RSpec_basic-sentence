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



