module Api
  module V1
    class SleepsController < ApiController
      def index
        @sleeps = SleepFinder.call(params[:user_id])
        render json: @sleeps, each_serializer: SleepSerializer
      end
    end
  end
end