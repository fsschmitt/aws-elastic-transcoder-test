# Set the following ENV variables:
#     ENV['S3_BUCKET_NAME'],
#     ENV['AWS_ACCESS_KEY_ID'],
#     ENV['AWS_SECRET_ACCESS_KEY']
#     ENV['AWS_REGION']
#

module ElasticTranscoder
  class TranscodeVideo
    require 'aws-sdk'
    def initialize
      @elastictranscoder = Aws::ElasticTranscoder::Client.new
    end

    # Creates a pipeline on AWS Elastic Transcoder
    def create_pipeline name, input_bucket, output_bucket, role
      begin
        @elastictranscoder.create_pipeline(
          name: name,
          input_bucket: input_bucket,
          output_bucket: output_bucket,
          role: role
        )
      rescue
        #Raise informative exception
      end
    end

    # Deletes a pipeline on AWS Elastic Transcoder given an id
    def delete_pipeline id
      begin
        @elastictranscoder.delete_pipeline(id: id)
      rescue
        #Raise informative exception
      end
    end

    def create_job pipeline_id, preset_id, input_file, output_folder, output_file
      @elastictranscoder.create_job(
        pipeline_id: pipeline_id,
        input: {
          key: input_file,
        },
        outputs: [
          {
            key: output_file,
            thumbnail_pattern: "thumb-{count}-{resolution}", #thumbnail generation based on pattern
            preset_id: preset_id
          }
        ],
        output_key_prefix: output_folder
      )
    end

    # List all pipelines
    def list_pipelines
      begin
        @elastictranscoder.list_pipelines(ascending: "true")[:pipelines]
      rescue
        #Raise informative exception
      end
    end

    def list_jobs id
      begin 
        @elastictranscoder.list_jobs_by_pipeline(pipeline_id: id)[:jobs]
      rescue
        #Raise informative exception
      end
    end

    def list_presets
      begin
        @elastictranscoder.list_presets[:presets]
      rescue
        #Raise informative exception
      end
    end
  end
end
