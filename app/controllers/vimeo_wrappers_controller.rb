class VimeoWrappersController < ApplicationController

	before_filter :initialize

  def initialize
  	@vimeoAdapter = Vimeo::Advanced::Video.new("f5dc41bedcf6c585a3d7d03578c84e08b0eb36ef", 
    																											"e1c94d369a4b052ea4ef2a809ee0e3a666fa6d47")
  end

  # GET /vimeo.json
  def index
  	if !params[:query].nil?
  		response = @vimeoAdapter.search(params[:query], { :page => "1", :per_page => "10", :full_response => "1" })

	  	respond_to do |format|
	      format.json { render json: response}
	    end
	  end
	  # error message
  end

end
