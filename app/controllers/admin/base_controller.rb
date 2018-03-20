class Admin::BaseController < ApplicationController
    layout 'admin'
    before_action :ensure_admin

    private
      def ensure_admin
        unless current_user && current_user.type == 'Admin'
          flash[:warning] = t('admin.restricted_access')
          redirect_to root_url
        end
      end
end
