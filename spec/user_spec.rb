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


#let を使った書き換え。

#let は遅延評価。= 必要になる瞬間まで呼び出されない。
#let はexampleがことなる場合は異なるオブジェクトを返す。

#let の利点
  #1.letを使わずインスタンス変数を生成する場合は、typo(打ち間違えなど)するとnil　で初期化するが、
  #  letはtypoするとエラーが発生するので、ミスに気づき対処しやすい。
  #2.使われる瞬間に呼び出されるため、無駄な時間を削減出来る。

#評価順番

# 1. expect(user.greet).to → userを呼び出す。
# 2. let(:user){User.new(params)} → paramsを呼び出す。
# 3. let(:params){{name:"たろう", age: age}}　→　ageを呼び出す。
# 4. let(:age){12} or let(:age){13} によってそれぞれ呼び出す。

# 5. expect(user.greet).to が指定した値として評価される。

RSpec.describe User do 
  describe "#greet" do 
    
    #{name:"太郎"}　を　params として参照出来る。
    
    let(:params){{name: "たろう", age: age}}
    let(:user){User.new(params)}
    
    #上の書き換え
    
    # let(:params) do 
    #   hash = {}
    #   hash[:name] = "たろう"
    #   hash
    # end
    
    context "12歳以下の場合" do 
      # before do 
      #   params.merge!(age:12)
      # end
      let(:age){12}
      
      it "ひらがなで答えること" do 
        # user = User.new(params)
        expect(user.greet).to eq "ぼくはたろうだよ。"
      end
    end
    
    context "13歳以上の場合" do 
      # before do 
      #   params.merge!(age:13)
      # end
      let(:age){13}
      
      it "漢字で答えること" do 
        # user = User.new(params)
        expect(user.greet).to eq "僕はたろうです。"
      end
    end
  end
end


# subjectを使った書き換え。
# subject =　テストの主語として解釈出来る。

# 1.subjectを使えば、テスト対象のオブジェクト、メソッドの実行結果[ここではuser.greet]
#   が一つに決まっている場合にまとめることが出来る。
# 2.expect(user.greet).to eq "~" →　is_expected_to eq "~"　にする。

RSpec.describe User do 
  describe "#greet" do 
    
    # let(:params){{name:"たろう", age: age}}
    let(:user){User.new({name:"たろう",age: age})}
    subject {user.greet}
    
    context "12歳以下の場合" do 
      let(:age){12}
      # it に渡す文字列を省略出来る。
      it { is_expected.to eq "ぼくはたろうだよ。"}
    end
    
    context "13歳以上の場合" do 
      let(:age){13}
      it { is_expected.to eq "僕はたろうです。"}
    end
    
  end
end


#itやcontextに渡す文字列を英語で書く場合。

#context に渡す英語の例
# ・when~ (~であるとき)
# ・with~ (~がある場合)
# ・without~ (~がない場合)


RSpec.describe User do 
  describe "#greet" do 
    let(:user){User.new(name:"たろう", age: age)}
    subject {user.greet}
    
    context "when 12 years old or younger" do 
      let(:age){12}
      it "greets in hiragana" do 
        is_expected.to eq "ぼくはたろうだよ。" 
      end
    end
    
    context "when 13 years old or older" do 
      let(:age){13}
      it "greets in kanji" do
        is_expected.to eq "僕はたろうです。" 
      end
    end
  end
end



# shared_examples, it_behaves_like を使う。
# 同じexampleをまとめて、DRYするために使う。


RSpec.describe User do 
  describe "#greet" do 
    let(:user){User.new(name: "たろう", age: age)}
    subject{user.greet}
    
    # shared_examples "~" do .. end で再利用したexampleを定義
    
    shared_examples "子どものあいさつ(12歳以下)" do 
      it{is_expected.to eq "ぼくはたろうだよ。"}
    end
    
    context "0歳の場合" do 
      let(:age){0}
      # it_behaves_like "~" で 定義したexampleを呼び出す。
      it_behaves_like "子どものあいさつ(12歳以下)"
    end
    
    context "12歳の場合" do 
      let(:age){12}
      it_behaves_like "子どものあいさつ(12歳以下)"
    end
    
    shared_examples "大人のあいさつ(13歳以上)" do 
      it {is_expected.to eq "僕はたろうです。"}
    end
    
    context "13歳の場合" do 
      let(:age){13}
      it_behaves_like "大人のあいさつ(13歳以上)"
    end
    
    context "100歳の場合" do 
      let(:age){100}
      it_behaves_like "大人のあいさつ(13歳以上)"
    end
  end
end