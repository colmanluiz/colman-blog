class Post < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy # apaga todos os arquivos dependentes de uma instancia desse modelo

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  scope :draft, -> { where(publlished_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
