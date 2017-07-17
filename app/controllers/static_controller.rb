class StaticController < ApplicationController

  layout 'static'

  def help
    @title = 'Freshair.org.uk IT: a simple guide for users'
    @guide = File.read('./doc/instructions.md')
  end

end
