module Intercom
  module Ex2
    class Location
      EARTH_RADIUS = 6372.795477598 * 1000

      attr_reader :latitude, :longitude

      def initialize latitude, longitude
        @latitude, @longitude = latitude, longitude
      end

      # distance in meters between two locations
      def distance_to other_location
        # formula: https://en.wikipedia.org/wiki/Great-circle_distance

        φ1 = degrees2radians self.latitude
        λ1 = degrees2radians self.longitude

        φ2 = degrees2radians other_location.latitude
        λ2 = degrees2radians other_location.longitude

        Δλ = λ2 - λ1

        EARTH_RADIUS * Math.acos(
          Math.sin(φ1) * Math.sin(φ2) + Math.cos(φ1) * Math.cos(φ2) * Math.cos(Δλ)
        )
      end

      def to_s
        "%s(latitude: %f, longitude: %f)" % [self.class, latitude, longitude]
      end

      private

      def degrees2radians degrees
        degrees * Math::PI / 180 
      end
    end
  end
end
