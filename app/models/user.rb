class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

      def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.nickname = auth.info.nickname
          end
      end

      def self.new_with_session(params, session)
        super.tap do |user|
          if data = session['devise.wechat_data']
            user.provider = data['provider']
            user.uid = data['uid']
          end
        end
      end
end
