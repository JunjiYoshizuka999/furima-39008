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
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end
      it 'emailが必須である' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailが一意性である' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが必須である' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上必須' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英数字混合での入力が必須' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword(確認)は、値の一致が必須' do
        @user.password = '123456'
        @user.password_confirmation = '654321'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'お名前(全角)は、名字が必須' do
        @user.second_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Second name is invalid'
      end
      it 'お名前(全角)は、名前が必須' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it 'お名前カナ(全角)は、名字が必須' do
        @user.name_katakana_second = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Name katakana second is invalid'
      end
      it 'お名前カナ(全角)は、名前が必須' do
        @user.name_katakana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Name katakana first is invalid'
      end
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須' do
        @user.name_katakana_first = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Name katakana first is invalid'
      end
      it '生年月日が必須' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
