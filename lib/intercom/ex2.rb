require 'json'
require 'slop'
require 'unindent'

module Intercom
  module Ex2
    DEFAULT_LOCATION = "53.339371,-6.259684"

    def self.find_nearby_customers center_location, radius_in_m, customers_stream = $stdin
      matched_customers = [] #OPTIMIZE for bigger sets we might use SortedSet

      customers_stream.each do |line|
        customer = JSON.parse line
        customer_location = Intercom::Ex2::Location.new customer['latitude'].to_f, customer['longitude'].to_f
        distance = center_location.distance_to(customer_location)

        if distance <= radius_in_m
          customer[:distance] = distance
          matched_customers << customer
        end
      end

      matched_customers.sort_by { |c| c['user_id'].to_i }
    end

    def self.format_customer_for_output customer, verbose
      if verbose
        customer
      else
        {
          user_id: customer['user_id'],
          name: customer['name']
        }
      end.to_json
    end

    def self.run args: ARGV, customers_stream: $stdin, output_stream: $stdout
      # DEFAULT_RADIUS = 100

      opts = Slop.parse args, suppress_errors: true do |o|
        o.banner = <<-TEXT.unindent
          A program that reads the full list of customers from STDIN and outputs the names and user ids of matching customers, sorted by user id (ascending).

          The input must consists of one customer per line, JSON-encoded, eg.:
              {"latitude": "52.986375", "user_id": 12, "name": "Christina McArdle", "longitude": "-6.043701"}
              {"latitude": "51.92893", "user_id": 1, "name": "Alice Cahill", "longitude": "-10.27699"}
        TEXT

        o.separator "OPTIONS:"
        o.string '--location', "A center of a location in a format of latitude,longitude (default: #{ DEFAULT_LOCATION }).", default: DEFAULT_LOCATION
        o.integer '--radius', "Show customers within a radius in km." # (default: #{ DEFAULT_RADIUS }.", default: DEFAULT_RADIUS
        o.bool '--verbose'
        o.on '--version', 'Print the version.' do
          output.puts Intercom::Ex2::VERSION
          exit
        end
        o.on '--help'
      end

      if opts[:location] && opts[:radius]
        center = Intercom::Ex2::Location.new *opts[:location].split(',').map(&:to_f)
        radius_in_m = opts[:radius] * 1000

        Intercom::Ex2.find_nearby_customers(center, radius_in_m, customers_stream).each do |customer|
          output_stream.puts format_customer_for_output customer, opts[:verbose]
        end
      else
        output_stream.puts opts
        output_stream.puts "", <<-TEXT.unindent
          EXAMPLES:
              intercom_ex2_customer_invitation < customers.txt
              intercom_ex2_customer_invitation --radius 100 < customers.txt # for Intercom office location
              intercom_ex2_customer_invitation --location 53.339371,-6.259684 --radius 100 < customers.txt
        TEXT
      end
    end
  end
end
