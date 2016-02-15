require 'intercom/ex2'

RSpec.describe Intercom::Ex2 do
  let(:intercom_office_location) { Intercom::Ex2::Location.new 53.3381985, -6.2592576 }
  let(:customers)                { File.readlines 'fixtures/customers.txt' }
  let(:nearby_customers)         { File.read 'fixtures/nearby_customers.txt' }
  let(:radius_in_m)              { 100000 }

  describe '.run' do
    before(:each) { @output = StringIO.new }
    subject       { @output.string }

    context 'given Intercom customers' do
      it 'outputs nearby customers' do
        Intercom::Ex2.run(
          args: %W[
            --location #{ intercom_office_location.latitude },#{ intercom_office_location.longitude }
            --radius 100
          ],
          customers_stream: customers,
          output_stream: @output,
        )

        is_expected.to eq(nearby_customers)
      end
    end
  end
end
