class Player < ApplicationRecord
    has_many :wins, class_name: 'Match', foreign_key: :winner_id, dependent: :destroy
    has_many :losses, class_name: 'Match', foreign_key: :loser_id, dependent: :destroy

    validates :name, presence: true
    validates :age, presence: true, numericality: { only_integer: true, greater_than: 10, less_than: 100 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone, presence: true, uniqueness: true

    scope :active, -> { where(active: true) }

    def soft_delete
        update(active: false)
    end

    def win_count
        wins.count
    end

    def loss_count
        losses.count
    end
end
