class Admin::BaseController < ApplicationController
    before_action :ensure_admin

    private
      def ensure_admin
        unless current_user && current_user.type == 'admin'
          redirect_to root_url, notice: 'Only admin'
        end
      end
end
