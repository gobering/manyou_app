class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: { 未着手:0, 着手中:1, 完了:2 }
  scope :search_title, -> (title) {where("title LIKE ?", "%#{title}%")}
  scope :search_status, -> (status) {where(status: status)}
  enum priority: { 高:0, 中:1, 低:2 }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
