class AttachmentsController < ApplicationController

  def show
    @attachment = Attachment.find(params[:id])
    send_data @attachment.data,
      :filename => @attachment.file_name,
      :type => @attachment.content_type
  end

  def new
    @attachment = Attachment.new
  end

  def create
    return if params[:attachment].blank?

    @attachment = Attachment.new
    @attachment.uploaded_file = params[:attachment]

    if @attachment.save
      redirect_to :back
    end
  end

end
