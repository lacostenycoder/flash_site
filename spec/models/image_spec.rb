require 'rails_helper'

describe 'validations' do
  let(:image) { Image.new() }

  it 'has a validate method' do
    expect(image).to respond_to(:validates_attachment_content_type)
    expect(image.valid?).to be false
    expect(image.errors.details).to eq({:imageable=>[{:error=>:blank}]})
    expect(image.errors.keys).not_to include(:deal)
  end
end
