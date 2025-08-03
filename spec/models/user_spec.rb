require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confirmation、' \
         'last_nameとfirst_name、first_name_kanaとlast_name_kana、' \
         'birth_date全てが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
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
      it 'passwordが英語だけの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字混合で入力してください')
      end
      it 'passwordが数字だけの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字混合で入力してください')
      end
      it 'passwordに全角文字が含まれていると登録できない' do
        @user.password = 'Ａ12345'
        @user.password_confirmation = 'Ａ12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password 半角英数字混合で入力してください')
      end
      it 'first_nameに全角英語が含まれていると登録できない' do
        @user.first_name = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_nameに全角英語が含まれていると登録できない' do
        @user.last_name = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameに半角文字が含まれていると登録できない' do
        @user.first_name = 'ﾒｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_nameに半角文字が含まれていると登録できない' do
        @user.last_name = 'ｾｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameに全角数字が含まれていると登録できない' do
        @user.first_name = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_nameに全角数字が含まれていると登録できない' do
        @user.last_name = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameに全角記号が含まれていると登録できない' do
        @user.first_name = '名！'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_nameに全角記号が含まれていると登録できない' do
        @user.last_name = '姓！'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_name_kanaに全角英語が含まれていると登録できない' do
        @user.first_name_kana = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end
      it 'last_name_kanaに全角英語が含まれていると登録できない' do
        @user.last_name_kana = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
      it 'first_name_kanaにひらがなが含まれていると登録できない' do
        @user.first_name_kana = 'めい'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end
      it 'last_name_kanaにひらがなが含まれていると登録できない' do
        @user.last_name_kana = 'せい'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
      it 'first_name_kanaに漢字が含まれていると登録できない' do
        @user.first_name_kana = '名'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end
      it 'last_name_kanaに漢字が含まれていると登録できない' do
        @user.last_name_kana = '姓'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
      it 'first_name_kanaに全角数字が含まれていると登録できない' do
        @user.first_name_kana = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end
      it 'last_name_kanaに全角数字が含まれていると登録できない' do
        @user.last_name_kana = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
      it 'first_name_kanaに全角記号が含まれていると登録できない' do
        @user.first_name_kana = '名！'
        @user.valid?
        expect(@user.errors.full_messages).to include('"First name kana 全角カタカナで入力してください')
      end
      it 'last_name_kanaに全角記号が含まれていると登録できない' do
        @user.last_name_kana = '姓！'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
    end
  end
end
