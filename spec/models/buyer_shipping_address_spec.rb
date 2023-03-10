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
        expect(@buyer_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと購入できない' do
        @buyer_shipping_address.post_code = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンがないと購入できない' do
        @buyer_shipping_address.post_code = '1234567'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が空では購入できない' do
        @buyer_shipping_address.prefecture_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が「--」では購入できない' do
        @buyer_shipping_address.prefecture_id = '1'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市町村が空では購入できない' do
        @buyer_shipping_address.municipality = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では購入できない' do
        @buyer_shipping_address.address = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では購入できない' do
        @buyer_shipping_address.telephone_number = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号が短すぎると購入できない' do
        @buyer_shipping_address.telephone_number = '123'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include('Telephone number is too short (minimum is 10 characters)')
      end
      it '電話番号が長すぎると購入できない' do
        @buyer_shipping_address.telephone_number = '123456789123456789'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include('Telephone number is too long (maximum is 11 characters)')
      end
      it '電話番号は半角数字のみ入力できる' do
        @buyer_shipping_address.telephone_number = '１２３４５６７８９'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include('Telephone number is not a number')
      end
      it '電話番号にハイフンがあると購入できない' do
        @buyer_shipping_address.telephone_number = '090-1234-5678'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include('Telephone number is not a number')
      end
      it 'userが紐ついていないと購入できない' do
        @buyer_shipping_address.user_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐ついていないと購入できない' do
        @buyer_shipping_address.item_id = ''
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
