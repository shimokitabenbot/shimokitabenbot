# -*- coding: utf-8 -*-
class StatusController < ApplicationController

  # get status
  def get
    render :status => :ok, :json => {"last_access_date" => Time.current.utc.strftime('%Y-%m-%d %H:%M:%s')}.to_json 
  end

end
