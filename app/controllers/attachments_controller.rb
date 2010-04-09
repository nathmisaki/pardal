class AttachmentsController < InheritedResources::Base
  belongs_to :user, :polymorphic => true

  def show
    show! do |format|
    format.html { send_data @attachment.data,
      :filename => @attachment.file_name,
      :type => @attachment.content_type }
    end
  end

  def create
    @attachment = end_of_association_chain.send(method_for_build, {})
    @attachment.uploaded_file = params[:attachment][:uploaded_file]
    create! { current_user_path }
  end

end
