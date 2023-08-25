class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :draft, -> {where(published_at: nil)}
  scope :published, -> {where("published_at <= ?", Time.current)}
  scope :scheduled, -> {where("published_at > ?", Time.current)}
  # scope :sorted, -> { order(published_at: :desc) }
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def published_date
    published_date = ''

    if published?
      published_date = published_at.strftime("%B %-d, %Y")
    elsif scheduled?
      published_date = published_at.strftime("%B %-d, %Y") + " · Scheduled"
    elsif draft?
      published_date = 'Draft'
    end

    published_date
  end

end
