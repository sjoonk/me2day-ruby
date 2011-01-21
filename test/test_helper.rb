require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'redgreen'
require 'matchy'
require 'fakeweb'

FakeWeb.allow_net_connect = false # blocking all real requests

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
FIXTURES_DIR = File.join(File.dirname(__FILE__), 'fixtures')

require 'me2day'

class Test::Unit::TestCase
end
