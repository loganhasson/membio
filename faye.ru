require 'faye'
faye_server = Faye::RackAdapter.new(:mount => '/getting-started/faye', :timeout => 45)
run faye_server