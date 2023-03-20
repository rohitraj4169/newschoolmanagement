class User < ApplicationRecord
    has_secure_password
    before_save {self.email=email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{ maximum:105}, format: { with: VALID_EMAIL_REGEX }
  belongs_to :role
  belongs_to :teacher, class_name: "User", foreign_key: "teacher_id", optional: true
  has_many :students, class_name: "User", foreign_key: "teacher_id"
  has_many :teachers
end
