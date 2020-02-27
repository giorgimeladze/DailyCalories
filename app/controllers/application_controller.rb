require 'will_paginate/array'
class ApplicationController < ActionController::Base
  include DeviseWhitelist
  before_action :authenticate_user!
end
