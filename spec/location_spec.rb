require 'intercom/ex2/location'

RSpec.describe Intercom::Ex2::Location do
  describe '#distance_to' do
    DISTANCE_TOLERANCE = 0.004

    let(:dublin_location)   { Intercom::Ex2::Location.new  53.3381985,  -6.2592576 }
    let(:cork_location)     { Intercom::Ex2::Location.new  51.8960528,  -8.4980692 }
    let(:santiago_location) { Intercom::Ex2::Location.new -33.4724228, -70.7699136 }

    context 'distance between Dublin-Cork and Cork-Dublin' do
      it "should be the same" do
        expect(cork_location.distance_to(dublin_location)).to eq dublin_location.distance_to(cork_location)
      end

      it "should be ~220 km" do
        distance = 220_403
        expect(cork_location.distance_to(dublin_location)).to be_within(distance * DISTANCE_TOLERANCE).of(distance)
      end
    end

    context 'distance between Dublin-Santiago and Santiago-Dublin' do
      it "should be the same" do
        expect(dublin_location.distance_to(santiago_location)).to eq santiago_location.distance_to(dublin_location)
      end

      it "should be ~11477 km" do
        distance = 11_476_837
        expect(dublin_location.distance_to(santiago_location)).to be_within(distance * DISTANCE_TOLERANCE).of(distance)
      end
    end
  end
end
