class Post < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy # apaga todos os arquivos dependentes de uma instancia desse modelo

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
