class ImagesController < ApplicationController
  before_action :require_login

  def create
    blob = ActiveStorage::Blob.create_and_upload!(
      io: params[:image][:file].tempfile,
      filename: params[:image][:file].original_filename,
      content_type: params[:image][:file].content_type
    )
    render json: { url: url_for(blob) }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
