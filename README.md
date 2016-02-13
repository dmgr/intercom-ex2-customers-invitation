# Intercom customers invitation script

A program that reads the full list of customers from STDIN and outputs the names and user ids of matching customers, sorted by user id (ascending).
The input must consists of one customer per line, JSON-encoded, eg.:

    {"latitude": "52.986375", "user_id": 12, "name": "Christina McArdle", "longitude": "-6.043701"}
    {"latitude": "51.92893", "user_id": 1, "name": "Alice Cahill", "longitude": "-10.27699"}

## Installation

    $ git clone 'https://github.com/dmgr/intercom-ex2-customers-invitation.git'
    $ cd intercom-ex2-customers-invitation
    $ bundle

## Usage

    intercom_ex2_customer_invitation --radius 100 < customers.txt # for Intercom office location
    intercom_ex2_customer_invitation --location 53.3381985,-6.2592576 --radius 100 < customers.txt
    intercom_ex2_customer_invitation --help
