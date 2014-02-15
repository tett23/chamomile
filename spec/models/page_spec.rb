require 'spec_helper'

describe Page do
  describe '#estimate_name' do
    it 'bodyが空' do
      expect do
        Page.new(body: '').estimate_name()
      end.to raise_error
    end

    it 'パースできるもの' do
      page = Page.new(body: "h1. foo\n\n\nbar\nbaz")
      page.estimate_name()

      expect(page.name).to eq('foo')
    end
  end

  describe '#concat' do
    it do
      concat = Page.new(name: 'foo', body: 'bar').concat()
      expect(concat).to eq("h1. foo\n\nbar")
    end
  end

  describe '::find_by_flagment' do
    it 'slugがあるもの' do
      slug = Page.find_by_wiki_slug_and_flagment(:test, :index).slug
      expect(slug).to eq('index')
    end

    it 'slugとnameどちらも存在するものをStringで検索' do
      slug = Page.find_by_wiki_slug_and_flagment(:test, 'index').slug
      expect(slug).to eq('index')
    end

    it 'nameのみのもの' do
      body = Page.find_by_wiki_slug_and_flagment(:test, 'slugなし').body
      expect(body).to eq('foo')
    end
  end
end
