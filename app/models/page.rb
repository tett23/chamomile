class Page < ActiveRecord::Base
  belongs_to :wiki

  before_save do
    self.slug = nil if self.slug.blank?
  end

  def concat
    "h1. #{self.name}\n\n#{self.body}"
  end

  def estimate_name
    first_line = self.body.strip.lines.first
    raise 'Page#estimate_name: bodyが空' if first_line.nil?

    self.name = first_line.strip.gsub(/h1\.\s+?/, '')

    self.name
  end

  def self.find_by_wiki_slug_and_flagment(wiki_slug, flagment)
    wiki_slug = wiki_slug.to_s if wiki_slug.class == Symbol
    wiki = Wiki.find_by(slug: wiki_slug)
    return nil if wiki.nil?

    if flagment.class == Symbol
      page = Page.find_by(slug: flagment, wiki_id: wiki.id)
      return page
    end

    page = Page.find_by(slug: flagment, wiki_id: wiki.id)
    return page unless page.nil?

    Page.find_by(name: flagment, wiki_id: wiki.id)
  end

  def flagment
    self.slug || self.name
  end

  def self.recent_edit(user_id, count=5)
    Page.where(user_id: user_id).order(updated_at: :desc).limit(count)
  end
end
