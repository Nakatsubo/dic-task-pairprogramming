class VendingMachine

  # 定数
  # 使えるお金
  MONEY = [10, 50, 100, 500, 1000].freeze

  # インスタンス変数
  # => インスタンスから変数を呼び出す
  attr_accessor :slot_money, :change_money, :drinks, :purchase_amount

  # initializeメソッド
  # => インスタンスを生成するのと同時に、変数の値を初期化する
  # => #<VendingMachine:0x00007fe01d91f640 @slot_money=0, @change_money=0, @product_hash={:コーラ=>{:price=>120, :count=>5}}, @purchase_amount=0>
  def initialize
    @slot_money = 0 # => 投入金額
    @change_money = 0 # => 払い戻し金額
    @drinks = [
       {product: 'cola', price: 120, count: 5},
       {product: 'redbull', price: 200, count: 5},
       {product: 'water', price: 100, count: 5}
      # ステップ4の処理
    ] # => ジュースの種類
    @purchase_amount = 0 # => 売り上げ金額
  end

  # 投入したお金をゼロにする
  # => vm.return_money
  # => value
  def return_money
    @change_money += @slot_money
    @slot_money = 0
  end

  # 投入したお金の合計処理
  # => vm.slot_money(1000)
  # => value
  def slot_money(money)
    if valid_money?(money)
      @slot_money += money
    else
      @change_money += money
    end
  end

  # お金が使えるか処理 => お金の合計処理に含める
  # => true or false
  def valid_money?(money)
    MONEY.include?(money)
  end

  # 自動販売機のジュースの種類
  # => vm.list_drink
  def list_drink
    @drinks
  end

  # 自動販売機の残りのジュースの種類、数
  # => vm.list_drink?
  def list_drink?
    result = []
    @drinks.each do |drink|
      if drink[:count] >= 1 && @slot_money >= drink[:price]
        result << drink[:product]
      end
    end
    result
  end
  # ステップ2まで ########################################

  # ステップ4の処理
  # 自動販売機のジュースの在庫
  # vm.drink_count(0)
  # => value
  def drink_count(number)
    @drinks[number][:count]
  end

  # ここから自動販売機の処理
  # vm.purchase(0)
  # => value
  def purchase(number)
    # => 購入できるかどうか
    return unless purchase?(number) # => falseになったらreturn
    @purchase_amount += @drinks[number][:price] # => 売り上げ金額
    @slot_money -= @drinks[number][:price] # => 購入金額
    @drinks[number][:count] -= 1 # => ジュースの在庫
  end

  # 残金と在庫が存在したらtrueを返す処理
  # => true or false
  # vm.purchase?(0)
  def purchase?(number)
    balance_amount?(number) && drinks_exist?(number)
  end

  # 残金が存在するかどうか処理
  # => true or false
  # vm.balance_amount?(0)
  def balance_amount?(number)
    @drinks[number][:price] <= @slot_money
  end

  # 在庫が存在するかどうか処理
  # => true or false
  # vm.drinks_exist?(0)
  def drinks_exist?(number)
    0 < @drinks[number][:count]
  end
  # ステップ3まで ########################################

  # ステップ5の処理
  # 釣り銭と売り上げ管理を処理
  # => vm.manage_amount(0)
   def manage_amount(number)
    if purchase?(number)
      @slot_money
    end
   end

end
