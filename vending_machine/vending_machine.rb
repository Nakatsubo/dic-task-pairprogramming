class VendingMachine

  # 定数
  # 使えるお金
  MONEY = [10, 50, 100, 500, 1000].freeze

  # インスタンス変数
  # => インスタンスから変数を呼び出す
  attr_accessor :slot_money, :change_money, :purchase_amount

  # initializeメソッド
  # => インスタンスを生成するのと同時に、変数の値を初期化する
  # => #<VendingMachine:0x00007fe01d91f640 @slot_money=0, @change_money=0, @product_hash={:コーラ=>{:price=>120, :count=>5}}, @purchase_amount=0>
  def initialize
    @slot_money = 0 # => 投入金額
    @change_money = 0 # => 払い戻し金額
    @list_drinks = {
      'コーラ': {price: 120, count: 5},
      'レッドブル': {price: 200, count: 5},
      '水': {price: 100, count: 5}
      # ステップ4の処理
    } # => ジュースの種類
    @purchase_amount = 0 # => 売り上げ金額
  end

  # 投入したお金の払い戻し処理
  # => value
  def return_money
    @change_money += @slot_money
    @slot_money = 0
  end

  # 投入したお金の合計処理
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
  # => {:コーラ=>{:price=>120, :count=>5}}
  def list_drink
    @list_drinks
  end
  # ステップ2まで ########################################

  # ステップ4の処理
  # 自動販売機のジュースの在庫
  # vm.drink_count(:コーラ)
  # => value
  def drink_count(drink_name)
    @list_drinks[drink_name][:count]
  end

  # ここから自動販売機の処理
  # vm.purchase(:コーラ)
  # => value
  def purchase(drink_name)
    # => 購入できるかどうか
    return unless purchase?(drink_name) # => falseになったらreturn
    @purchase_amount += @list_drinks[drink_name][:price] # => 売り上げ金額
    @slot_money -= @list_drinks[drink_name][:price] # => 購入金額
    @list_drinks[drink_name][:count] -= 1 # => ジュースの在庫
  end

  # 残金と在庫が存在したらtrueを返す処理
  # => true or false
  # vm.purchase?(:コーラ)
  def purchase?(drink_name)
    balance_amount?(drink_name) && drinks_exist?(drink_name)
  end

  # 残金が存在するかどうか処理
  # => true or false
  # vm.balance_amount?(:コーラ)
  def balance_amount?(drink_name)
    @list_drinks[drink_name][:price] <= @slot_money
  end

  # 在庫が存在するかどうか処理
  # => true or false
  # vm.drinks_exist?(:コーラ)
  def drinks_exist?(drink_name)
    0 < @list_drinks[drink_name][:count]
  end
  # ステップ3まで ########################################

  # ステップ5の処理
  # 釣り銭と売り上げ管理を処理
  # => vm.manage_amount(:コーラ)
   def manage_amount(drink_name)
     if @slot_money > @list_drinks[drink_name][:price]
       @slot_money
     else
       0
     end
   end

end

# コピペ用 irb
# require '/Users/nakatsuboyuusuke/Documents/dic_pairprogramming/vending_machine/vending_machine.rb'

# コピペ用 インスタンスを生成
# vm = VendingMachine.new
