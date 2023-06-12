class BlogPost < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
  
<<<<<<< HEAD
    scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc) }
=======
    scope :sorted, -> { order(published_at: :asc, updated_at: :desc) }
>>>>>>> 80a8200307955edbf06da6ab02c7e08d5a42b146
    scope :draft, -> { where(published_at: nil) }
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
  