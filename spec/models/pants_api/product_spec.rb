# describe PantsApi::Product do
#   let(:products_url) { 'http://localhost:3000/products' }

#   let(:json_api_headers) do
#     { content_type: "application/vnd.api+json" }
#   end

#   let(:products_response_data) do
#     [{ id: '1',
#        type: 'products',
#        attributes: { name: 'washed chinos',
#                      description: 'All-purpose cotton chinos',
#                      image: 'http://www.chinos.com/cotton.jpg' },
#        relationships: { variants: { data: [{ id: '1', type: 'variants' }] } } }]
#   end

#   let(:products_response_included) do
#     [{ id: '1',
#        type: 'variants',
#        attributes: { waist: 28, length: 36, style: 'jet blues', count: 75 } }]
#   end

#   let(:products_response_hash) do
#     { headers: json_api_headers,
#       body: { data: products_response_data,
#               included: products_response_included } }
#   end

#   before do
#     stub_request(:get, products_url).to_return(products_response.to_json)
#   end

#   it 'returns the products' do
#     expect(described_class.all.size).to eq(1)
#   end
# end
