# -*- coding: utf-8 -*-
=begin
Status Controller
=end
require 'spec_helper'
require 'base64'
describe StatusController, :controller => 'status', :action => 'get' do
  # リクエストパラメータ
  before(:each) do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  describe 'Succeed' do
    it 'get status' do
      get 'get'
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body['last_access_date']).not_to be_nil
    end
  end
end
