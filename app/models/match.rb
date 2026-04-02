class Match < ApplicationRecord
    belongs_to :winner, class_name: 'Player'
    belongs_to :loser, class_name: 'Player'

    validates :winner_id, presence: true
    validates :loser_id, presence: true
    validates :played_at, presence: true
    validate :winner_and_loser_must_be_different
    validate :played_at_must_be_past

    private

    def winner_and_loser_must_be_different
        if winner_id.present? && loser_id.present? && winner_id == loser_id
            errors.add(:base, 'Winner and loser must be different players')
        end
    end

    def played_at_must_be_past
        if played_at.present? && played_at > Time.current
            errors.add(:played_at, "can't be in the future")
        end
    end
end
