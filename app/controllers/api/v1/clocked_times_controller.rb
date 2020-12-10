module Api
  module V1
    class ClockedTimesController < ApiController
      def create
        @clocked_time = ClockedTimeCreator.call(clocked_time_params[:user_id], clocked_time_params[:action])
        if @clocked_time.errors.messages.empty?
          render json: @clocked_time, serializer: ClockedTimeSerializer
        else
          render_422(@clocked_time.errors.messages)
        end
      end

      def index
        @clocked_times = ClockedTime.joins(sleep: :user).where("sleeps.user_id = ?", params[:user_id])
        render json: @clocked_times, each_serializer: ClockedTimeSerializer
      end

      private

      def clocked_time_params
        params.require(:clocked_time).permit(:action, :user_id)
      end
    end
  end
end