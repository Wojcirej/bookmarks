RSpec.describe Category, type: :model do
  subject { create(:category) }
  it do
    is_expected.to have_db_column(:name).of_type(:string).with_options(
      null: false, limit: 30
    )
  end
  it { is_expected.to have_db_column(:ancestry).of_type(:string) }

  it do
    is_expected.to validate_presence_of(:name).with_message(
      'Please specify category name'
    )
  end
  it do
    is_expected.to validate_uniqueness_of(:name).with_message('Category exists')
  end
  it { is_expected.to validate_length_of(:name).is_at_most(30) }

  describe '.add_new' do
    context 'when valid params' do
      let(:params) { { name: 'Completely new name' } }

      it 'creates new Category' do
        expect { Category.add_new(params) }.to change { Category.count }.by(1)
      end

      it 'creates new Category with name as in params' do
        expect(Category.add_new(params).name).to eq(params[:name])
      end

      it 'returns persisted Category object' do
        expect(Category.add_new(params).persisted?).to be true
      end
    end

    context 'when invalid params' do
      let(:params) { { name: '' } }

      it 'does not create new Category' do
        expect { Category.add_new(params) }.not_to change { Category.count }
      end

      it 'returns Category object with validation errors' do
        expect(Category.add_new(params).errors[:name]).to include(
          'Please specify category name'
        )
      end

      it 'returns not persisted Category object' do
        expect(Category.add_new(params).persisted?).to be false
      end
    end
  end

  describe '.list' do
    let(:root) { subject }
    let!(:child) { create(:category, parent: subject) }
    let!(:grand_child) { create(:category, parent: child) }
    let!(:sibling_of_child) { create(:category, parent: subject) }

    it 'returns array of Category objects ordered by its tree structure' do
      expect(Category.list).to eq([root, child, grand_child, sibling_of_child])
    end
  end
end
