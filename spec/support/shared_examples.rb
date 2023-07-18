# frozen_string_literal: true

RSpec.shared_examples 'raises a ValidationError when field is nil' do
  it 'raises a ValidationError' do
    expect { subject }.to raise_error Exceptions::ValidationError
  end
end

RSpec.shared_examples 'authorization variables' do
  let(:Authorization) { {} }
  let('access-token') { {} }
  let('token-type') { {} }
  let(:client) { {} }
  let(:expiry) { {} }
  let(:uid) { {} }
end
