require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { FactoryGirl.build(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 3 }

  it { should have_many(:items) }

  it { should have_attached_file(:image) }

  it do
    should validate_attachment_content_type(:image)
      .allowing('image/png', 'image/jpg', 'image/jpeg')
      .rejecting('text/plain', 'text/xml')
  end
  it { should validate_attachment_size(:image).less_than(1.megabytes) }

  describe 'before_save' do
    it 'should invoke #name_capitalize' do
      expect(subject).to receive(:name_capitalize)
      subject.save!
    end
  end

  describe 'after_create' do
    it 'should invoke #parent_count_increase' do
      expect(subject).to receive(:parent_count_increase)
      subject.save!
    end

    it 'should #parent_count_increase +1' do
      subject.save!
      count = subject.children_count
      subject.children.create!(name: 'Запчасти для комбайнов')
      expect(subject.children_count).to eq count + 1
    end
  end

  describe 'after_destroy' do
    it 'should invoke #parent_count_decrease' do
      expect(subject).to receive(:parent_count_decrease)
      subject.destroy!
    end

    it 'should #parent_count_decrease -1' do
      subject.save!
      count = subject.children_count
      subject.children.create!(name: 'Запчасти для комбайнов')
      subject.children.destroy_all
      expect(Category.find(subject.id).children_count).to eq count
    end
  end
end
