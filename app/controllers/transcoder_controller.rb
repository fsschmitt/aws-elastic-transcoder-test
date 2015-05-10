class TranscoderController < ApplicationController
  require 'elastic_transcoder'
  def index

  end

  def jobs
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    @jobs = transcode_video.list_jobs params[:id]
    puts @jobs
  end

  def pipelines
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    @pipelines = transcode_video.list_pipelines
  end

  def presets
  end

  def create
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    @pipelines = transcode_video.list_pipelines
    @presets = transcode_video.list_presets
  end

  def execute
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    transcode_video.create_job params[:pipeline], params[:preset], params[:input_file], params[:output_folder], params[:output_file]
    redirect_to "/transcoder/jobs/#{params[:pipeline]}"
  end
end
