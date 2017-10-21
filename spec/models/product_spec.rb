require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:products_url) { 'http://localhost:3535/products' }

  let(:json_api_headers) do
    { content_type: "application/vnd.api+json" }
  end

  let(:name) { 'washed chinos' }
  let(:description) { 'All-purpose cotton chinos' }
  let(:image) { 'http://www.chinos.com/cotton.jpg' }

  let(:products_response_data) do
    [{ id: '1',
       type: 'products',
       attributes: { name: name, description: description, image: image },
       relationships: { variants: { data: [{ id: '1', type: 'variants' }] } } }]
  end

  let(:products_response_included) do
    [{ id: '1',
       type: 'variants',
       attributes: { waist: 28, length: 36, style: 'jet blues', count: 75 } }]
  end

  let(:products_response) do
    { headers: json_api_headers,
      body: { data: products_response_data,
              included: products_response_included }.to_json }
  end

  before do
    stub_request(:get, products_url).to_return(products_response)
  end

  describe '.all' do
    subject(:products) { described_class.all }
    
    it 'returns all the products' do
      expect(products.size).to eq(1)
    end

    it 'contains the product attributes' do
      expect(products.first)
        .to have_attributes(id: '1',
                            type: 'products',
                            name: name,
                            description: description,
                            image: image)
    end

    it 'contains the associated variants' do
      expect(products.first.variants.size).to eq(1)
    end

    it 'contains the associated variant attributes' do
      expect(products.first.variants.first)
        .to have_attributes(id: '1',
                            type: 'variants',
                            waist: 28,
                            length: 36,
                            style: 'jet blues',
                            count: 75)
    end
  end
end
