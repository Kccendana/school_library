# book_spec.rb
require_relative '../book'
require 'rspec'

describe Book do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }

  context 'when creating a new book' do
    it 'should have the correct attributes' do
      expect(book.title).to eq('The Great Gatsby')
      expect(book.author).to eq('F. Scott Fitzgerald')
      expect(book.rentals).to be_nil
    end
  end

  context 'when converting a book to a hash' do
    it 'should have the correct hash structure' do
      hash = book.to_hash

      expect(hash['title']).to eq('The Great Gatsby')
      expect(hash['author']).to eq('F. Scott Fitzgerald')
    end
  end
end
