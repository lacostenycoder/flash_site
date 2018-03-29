class Admin::BaseController < ApplicationController
    before_action :ensure_admin

    private
      def ensure_admin
        unless current_user && current_user.admin?
          flash[:warning] = t('admin.restricted_access')
          redirect_to root_url
        end
      end
end
