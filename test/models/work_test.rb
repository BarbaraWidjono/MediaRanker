require 'test_helper'


describe Work do

  describe 'relations' do
    it 'each work can have many votes' do
      votes = Vote.where(work_id: "sound_of_music")
      expect(votes.count).must_equal 2
    end
  end

  describe 'validations' do

    before do
      @work = Work.new(title: 'casper babypants', category: 'album')
    end

    it 'is valid when title is unique and category are present' do
      is_valid = @work.valid?
      expect(is_valid).must_equal true
    end

    it 'is invalid if the title is not unique' do
      new_work = Work.new(title: "sound of music", category: "movie")
      is_valid = new_work.valid?
      expect(is_valid).must_equal false
    end

    it 'is not valid without a title' do
      @work.title = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end

    it 'is not valid without a category' do
      @work.category = nil
      is_valid = @work.valid?
      expect(is_valid).must_equal false
    end
  end

  describe 'custom_methods' do

    it 'returns the work id' do
      work = Work.find_by(title: "sound of music")
      work_id = work.find_work_id
      expect(work_id).must_be_kind_of Integer
    end

    it 'returns the total number of votes for a work' do
      user1 = User.create!(username: "junie")
      user2 = User.create!(username: "penelope")
      work = Work.create!(title: "Storks", category: "book")

      vote1 = Vote.create!(user_id: user1.id, work_id: work.id)
      vote2 = Vote.create!(user_id: user2.id, work_id: work.id)

      total_votes = work.total_votes
      expect(total_votes).must_equal 2
    end
  end
end
