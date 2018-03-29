module Admins
  class BaseController < ApplicationController
    layout 'admin'
    before_action :ensure_admin

    private
      def ensure_admin
        unless current_user && current_user.admin?
          redirect_to root_url, flash: { warning: t('admin.restricted_access') }
        end
      end
  end
end
