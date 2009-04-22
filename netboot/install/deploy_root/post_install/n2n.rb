#!/usr/bin/env ruby

require 'rubygems'
require 'net/http'
require 'json'

# URL = 'http://localhost:3000'
URL = 'http://dyndns.flyingseagull.de'

USERNAME = 'protonet'
PASSWORD = 'test'
NETWORK  = 'thenetwork'
PORT     = 1099

class Dyndns
  def create
    uri = "#{URL}/users/create"
    param = {
      '[user][key]' => PASSWORD,
      "[user][name]" => USERNAME,
      '[group][name]' => NETWORK,
      '[group][address]' => '192.168.2.1',
      '[group][port]' => PORT,
      '[group][public]' => true
    }

    res = Net::HTTP.post_form URI.parse(uri), param
  end

  def authenticate

  end

  def list
    uri = "#{URL}/groups/list"

    res = Net::HTTP.get URI.parse(uri)
  end

  def update(address)
    uri = "#{URL}/users/update"

    parameter = {
      'name' => USERNAME,
      'key' => PASSWORD,
      '[user][address]' => address
    }

    res = Net::HTTP.post_form URI.parse(uri), parameter
  end

  def groupupdate
    uri = "#{URL}/groups/update"

    parameter = {
      'name' => USERNAME,
      'key' => PASSWORD
    }

    res = Net::HTTP.post_form URI.parse(uri), parameter
  end
end

dyndns = Dyndns.new

case ARGV.first
when "update" then
  ARGV.shift
  dyndns.update(ARGV.first)
when "create" then
  dyndns.create
when "list" then
  list = dyndns.list
  res = JSON.parse(list) if list
  # dummy debug output for now
  puts res
  address = res[0]['group']['address']
  # apparently we need 2 forks here to actually run the process in the background
  fork do
    fork do
      system "/usr/bin/edge -d n2n0 -a 10.1.2.2 -c mynetwork -k encryptme -l #{address}"
    end
  end
when "groupup" then
  dyndns.groupupdate
end
