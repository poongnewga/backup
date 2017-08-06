class Contact < ActiveRecord::Base
   validates :name, :email, :message, presence: { message: "문의해주셔서 감사합니다^^" }
end