Geocoder::Lookup::Test.set_default_stub([{
    'latitude'     => 41.8869615,
    'longitude'    => -87.6264112,
    'address'      => '301 N Michigan Ave',
    'state'        => 'Illinois',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
 }])

stubs = [
  ["301 N Michigan Ave, Chicago, IL, 60601", [{
    'latitude'     => 41.8869615,
    'longitude'    => -87.6264112,
    'address'      => '301 N Michigan Ave',
    'state'        => 'Illinois',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
  }]],
  ["215 W Ohio St, Chicago, IL, 60601", [{
    'latitude'     => 41.8921404,
    'longitude'    => -87.6370182,
    'address'      => '215 W Ohio St',
    'state'        => 'Illinois',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
  }]],
  ["2515 W FLETCHER, CHICAGO, IL, 60618", [{
    'latitude'     => 41.9385003,
    'longitude'    => -87.6922708,
    'address'      => '2515 W FLETCHER',
    'state'        => 'Illinois',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
  }]],
  ["2600 W LAWRENCE, CHICAGO, IL, 60625", [{
    'latitude'     => 41.9687596,
    'longitude'    => -87.6961608,
    'address'      => '2600 W LAWRENCE',
    'state'        => 'Illinois',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
  }]],
  ["14915 CHARLEVOIX ST, DETROIT, MI, 48230", [{
    'latitude'     => 42.384867,
    'longitude'    => -82.9477555,
    'address'      => '14915 CHARLEVOIX ST',
    'state'        => 'Michigan',
    'state_code'   => 'MI',
    'country'      => 'United States',
    'country_code' => 'US'
  }]]
]

stubs.each do |stub|
  Geocoder::Lookup::Test.add_stub(*stub)
end
