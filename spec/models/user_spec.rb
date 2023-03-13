require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'name、email、password、password_confirmation、second_name、first_name、name_katakana_second、name_katakana_first、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nameが必須である' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが必須である' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'emailが一意性である' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが必須である' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordは6文字以上必須' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは不正な値です")
      end
      it 'passwordは半角英数字混合での入力が必須' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは全角では登録できない' do
        @user.password = '１２３ＡＢＣ'
        @user.password_confirmation = '１２３ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとpassword(確認)は、値の一致が必須' do
        @user.password = '123456'
        @user.password_confirmation = '654321'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'お名前(全角)は、名字が必須' do
        @user.second_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください", "名前は不正な値です"
      end
      it 'お名前(全角)は、名前が必須' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字を入力してください", "名字は不正な値です"
      end
      it 'お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名字は不正な値です"
      end
      it 'お名前(全角)苗字は、全角（漢字・ひらがな・カタカナ）での入力が必須' do
        @user.second_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は不正な値です"
      end
      it 'お名前カナ(全角)は、名字が必須' do
        @user.name_katakana_second = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）を入力してください", "名前（カナ）は不正な値です"
      end
      it 'お名前カナ(全角)は、名前が必須' do
        @user.name_katakana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字（カナ）を入力してください", "名字（カナ）は不正な値です"
      end
      it 'お名前カナ(全角)の名前は、全角（カタカナ）での入力が必須' do
        @user.name_katakana_first = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include "名字（カナ）は不正な値です"
      end
      it 'お名前カナ(全角)苗字は、全角（カタカナ）での入力が必須' do
        @user.name_katakana_second = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）は不正な値です"
      end
      it '生年月日が必須' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end
end
