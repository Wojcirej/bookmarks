RSpec.describe Link, type: :model do
  it do
    is_expected.to have_db_column(:name).of_type(:string).with_options(
      null: false, limit: 60
    )
  end
  it { is_expected.to have_db_column(:url).of_type(:string) }
  it { is_expected.to have_db_column(:description).of_type(:text) }
  it do
    is_expected.to have_db_column(:category_id).of_type(:uuid).with_options(
      null: false
    )
  end

  it { is_expected.to belong_to(:category) }

  it do
    is_expected.to validate_presence_of(:name).with_message(
      'Please specify link name'
    )
  end
  it { is_expected.to validate_length_of(:name).is_at_most(60) }
  it { is_expected.to validate_presence_of(:category_id) }

  describe '.add_new_to_category' do
    let(:category) { create(:category) }
    let(:category_id) { category.id }

    context 'when valid params' do
      let(:params) do
        {
          name: 'Completely new name',
          description: 'Some description',
          url: 'http://example.com/'
        }
      end

      it 'creates new Link' do
        expect { Link.add_new_to_category(params, category_id) }.to change {
          Link.count
        }.by(1)
      end

      it 'creates new Link associated with category with passed ID' do
        expect(Link.add_new_to_category(params, category_id).category_id).to eq(
          category_id
        )
      end

      it 'creates new Link with name as in params' do
        expect(Link.add_new_to_category(params, category_id).name).to eq(
          params[:name]
        )
      end

      it 'returns persisted Link object' do
        expect(
          Link.add_new_to_category(params, category_id).persisted?
        ).to be true
      end
    end

    context 'when invalid params' do
      let(:params) { { name: '' } }

      it 'does not create new Link' do
        expect { Link.add_new_to_category(params, category_id) }.not_to change {
          Link.count
        }
      end

      it 'returns not persisted Link object' do
        expect(
          Link.add_new_to_category(params, category_id).persisted?
        ).to be false
      end

      it 'returns Link object with errors' do
        expect(
          Link.add_new_to_category(params, category_id).errors[:name]
        ).to include('Please specify link name')
      end
    end
  end
end
