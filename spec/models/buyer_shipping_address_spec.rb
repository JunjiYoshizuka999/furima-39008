require 'rails_helper'

RSpec.describe BuyerShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buyer_shipping_address = FactoryBot.build(:buyer_shipping_address, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '購入できるとき' do
      it '全ての情報が正しく入力されていれば購入できる' do
        expect(@buyer_shipping_address).to be_valid
      end
      it '建物名は空でも購入できる' do
        @buyer_shipping_address.building_name = ''
        expect(@buyer_shipping_address).to be_valid
      end
    end
    context '購入できないとき' do
      it 'クレジットカードの情報（トークン）がないと購入できない' do
        @buyer_shipping_address.token = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it '郵便番号が空だと購入できない' do
        @buyer_shipping_address.post_code = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号にハイフンを入力してください")
      end
      it '郵便番号にハイフンがないと購入できない' do
        @buyer_shipping_address.post_code = '1234567'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("郵便番号にハイフンを入力してください")
      end
      it '都道府県が空では購入できない' do
        @buyer_shipping_address.prefecture_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it '都道府県が「--」では購入できない' do
        @buyer_shipping_address.prefecture_id = '1'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it '市町村が空では購入できない' do
        @buyer_shipping_address.municipality = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("市町村を入力してください")
      end
      it '番地が空では購入できない' do
        @buyer_shipping_address.address = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では購入できない' do
        @buyer_shipping_address.telephone_number = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は数値で入力してください", "電話番号は10文字以上で入力してください")
      end
      it '電話番号が短すぎると購入できない' do
        @buyer_shipping_address.telephone_number = '123'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end
      it '電話番号が長すぎると購入できない' do
        @buyer_shipping_address.telephone_number = '123456789123456789'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it '電話番号は半角数字のみ入力できる' do
        @buyer_shipping_address.telephone_number = '１２３４５６７８９'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it '電話番号にハイフンがあると購入できない' do
        @buyer_shipping_address.telephone_number = '090-1234-5678'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it 'userが紐ついていないと購入できない' do
        @buyer_shipping_address.user_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐ついていないと購入できない' do
        @buyer_shipping_address.item_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
