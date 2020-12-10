module Api
  module V1
    class FriendRelationshipsController < ApiController
      before_action :load_friend_relationship, only: [:create, :destroy]

      # an user can request to follow other users
      def create
        @friend_relationship = FriendRelationship.create(friend_relationship_params)
        if @friend_relationship.errors.messages.empty?
          render json: @friend_relationship, serializer: FriendRelationshipSerializer
        else
          render_422(@friend_relationship.errors.messages)
        end
      end

      # when receiving a request, user can confirm the request
      def confirm
        if @friend_relationship.update(confirmed: true)
          render json: @friend_relationship, each_serializer: FriendRelationshipSerializer
        else
          render_422(@friend_relationship.errors.messages)
        end
      end

      # unfollow other user
      def destroy
        if @friend_relationship.destroy
          render json: {success: true}
        else
          render_422("Cannot unfriend")
        end
      end

      private

      def load_friend_relationship
        @friend_relationship = FriendRelationship.find(params[:id])
      end
      def friend_relationship_params
        params.require(:friend_relationship).permit(:requester_id, :acceptor_id)
      end
    end
  end
end